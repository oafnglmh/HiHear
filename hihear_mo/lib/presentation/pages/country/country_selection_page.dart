import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/domain/entities/country_entity.dart';
import 'package:hihear_mo/presentation/blocs/country/country_bloc.dart';

class CountrySelectionPage extends StatefulWidget {
  const CountrySelectionPage({super.key});

  @override
  State<CountrySelectionPage> createState() => _CountrySelectionPageState();
}

class _CountrySelectionPageState extends State<CountrySelectionPage>
    with TickerProviderStateMixin {
  CountryEntity? _selectedCountry;
  late AnimationController _bambooController;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    context.read<CountryBloc>().add(const CountryEvent.loadCountries());

    _bambooController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _bambooController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _selectCountry(CountryEntity country) {
    setState(() {
      _selectedCountry = country;
    });
  }

  void _confirm() async {
    if (_selectedCountry != null) {
      context.read<CountryBloc>().add(
        CountryEvent.addOrUpdateCountry(_selectedCountry!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<CountryBloc, CountryState>(
          listener: (context, state) {
          state.whenOrNull(
            success: () {
              context.go('/start');
            },
          );
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF4A7C2C), // Xanh lá tre đậm
                    Color(0xFF5E9A3A), // Xanh lá tre
                    Color(0xFF3D6624), // Xanh lá tre sẫm
                  ],
                ),
              ),
            ),

            // Bamboo decoration
            AnimatedBuilder(
              animation: _bambooController,
              builder: (context, child) {
                return CustomPaint(
                  painter: BambooPainter(
                    animationValue: _bambooController.value,
                  ),
                  size: Size.infinite,
                );
              },
            ),

            // Content
            SafeArea(
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(child: _buildBody()),
                  if (_selectedCountry != null) _buildConfirmButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeTransition(
      opacity: _fadeController,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.2), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFD4AF37).withOpacity(0.3),
                ),
              ),
              child: IconButton(
                onPressed: () => context.go('/goalSelector'),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Chọn quốc gia",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "🇻🇳 Bạn đến từ đâu?",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
                ),
                const SizedBox(height: 16),
                Text(
                  "Đang tải...",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          success: () => const SizedBox(),
          error: (msg) => Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.red.withOpacity(0.5)),
              ),
              child: Text(
                msg,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          data: (countries) => _buildCountryList(countries),
          filtered: (countries) => _buildCountryList(countries),
        );
      },
    );
  }

  Widget _buildCountryList(List<CountryEntity> countries) {
    if (countries.isEmpty) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search_off,
                size: 48,
                color: Colors.white.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              const Text(
                "Không tìm thấy quốc gia",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: countries.length,
      itemBuilder: (_, i) {
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 + (i * 50)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(50 * (1 - value), 0),
              child: Opacity(
                opacity: value,
                child: _buildCountryCard(countries[i]),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCountryCard(CountryEntity country) {
    final isSelected = _selectedCountry?.code == country.code;

    return GestureDetector(
      onTap: () => _selectCountry(country),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                )
              : null,
          color: isSelected ? null : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFD4AF37)
                : Colors.white.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            // Flag
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(country.flag, style: const TextStyle(fontSize: 32)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                country.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (value * 0.2),
          child: Opacity(
            opacity: value,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _confirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(18),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Xác nhận",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Bamboo Painter - vẽ cây tre
class BambooPainter extends CustomPainter {
  final double animationValue;

  BambooPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2D5016).withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Vẽ cây tre bên trái
    _drawBamboo(canvas, size, 30, paint, animationValue);
    // Vẽ cây tre bên phải
    _drawBamboo(canvas, size, size.width - 30, paint, -animationValue);
  }

  void _drawBamboo(
    Canvas canvas,
    Size size,
    double x,
    Paint paint,
    double sway,
  ) {
    final path = Path();
    final segments = 6;
    final segmentHeight = size.height / segments;

    for (int i = 0; i < segments; i++) {
      final y = i * segmentHeight;
      final swayOffset = sway * 10 * (i / segments);

      // Thân tre
      path.moveTo(x + swayOffset, y);
      path.lineTo(x + swayOffset, y + segmentHeight - 10);

      // Đốt tre
      canvas.drawCircle(
        Offset(x + swayOffset, y + segmentHeight - 10),
        5,
        paint,
      );

      // Lá tre
      if (i > 2) {
        final leafPaint = Paint()
          ..color = const Color(0xFF6DB33F).withOpacity(0.2)
          ..style = PaintingStyle.fill;

        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(x + swayOffset + 15, y + segmentHeight / 2),
            width: 30,
            height: 10,
          ),
          leafPaint,
        );

        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(x + swayOffset - 15, y + segmentHeight / 2 + 5),
            width: 30,
            height: 10,
          ),
          leafPaint,
        );
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BambooPainter oldDelegate) => true;
}
