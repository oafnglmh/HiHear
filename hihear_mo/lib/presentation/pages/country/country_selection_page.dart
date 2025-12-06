import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/domain/entities/country/country_entity.dart';
import 'package:hihear_mo/presentation/blocs/country/country_bloc.dart';
import 'dart:math' as math;

class CountrySelectionPage extends StatefulWidget {
  const CountrySelectionPage({super.key});

  @override
  State<CountrySelectionPage> createState() => _CountrySelectionPageState();
}

class _CountrySelectionPageState extends State<CountrySelectionPage>
    with TickerProviderStateMixin {
  CountryEntity? _selectedCountry;
  late AnimationController _lotusController;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    context.read<CountryBloc>().add(const CountryEvent.loadCountries());

    _lotusController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _lotusController.dispose();
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
            // Background gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0A5C36), // Xanh lá sen đậm
                    Color(0xFF1B7F4E), // Xanh lá sen
                    Color(0xFF0D4D2D), // Xanh đậm
                  ],
                ),
              ),
            ),

            // Lotus pattern
            AnimatedBuilder(
              animation: _lotusController,
              builder: (context, child) {
                return CustomPaint(
                  painter: LotusPatternPainter(
                    animationValue: _lotusController.value,
                  ),
                  size: Size.infinite,
                );
              },
            ),

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

// Lotus Pattern Painter - Same as Login Page
class LotusPatternPainter extends CustomPainter {
  final double animationValue;

  LotusPatternPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    // Vẽ hoa sen góc trên phải
    _drawLotusFlower(
      canvas,
      Offset(size.width - 80, 100 + math.sin(animationValue * math.pi * 2) * 5),
      80,
      0.15 + animationValue * 0.05,
    );

    // Vẽ hoa sen góc dưới trái
    _drawLotusFlower(
      canvas,
      Offset(80, size.height - 150 + math.cos(animationValue * math.pi * 2) * 8),
      100,
      0.12 + animationValue * 0.03,
    );

    // Vẽ lá sen góc dưới phải
    _drawLotusLeaf(
      canvas,
      Offset(size.width - 100, size.height - 100 + math.sin(animationValue * math.pi * 2) * 6),
      70,
      0.1 + animationValue * 0.02,
    );

    // Vẽ lá sen nhỏ góc trên trái
    _drawLotusLeaf(
      canvas,
      Offset(60, 80 + math.cos(animationValue * math.pi * 2) * 4),
      50,
      0.08,
    );
  }

  void _drawLotusFlower(Canvas canvas, Offset center, double size, double opacity) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.pink.shade100.withOpacity(opacity);

    // Vẽ cánh hoa sen (8 cánh)
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi / 4) + (animationValue * 0.1);
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);

      final path = Path();
      path.moveTo(0, 0);
      path.quadraticBezierTo(
        size * 0.3, -size * 0.5,
        0, -size * 0.8,
      );
      path.quadraticBezierTo(
        -size * 0.3, -size * 0.5,
        0, 0,
      );

      canvas.drawPath(path, paint);
      canvas.restore();
    }

    // Vẽ nhụy hoa
    final centerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.yellow.shade300.withOpacity(opacity * 1.5);

    canvas.drawCircle(center, size * 0.15, centerPaint);

    // Vẽ chi tiết nhụy
    for (int i = 0; i < 12; i++) {
      final angle = i * math.pi / 6;
      final x = center.dx + math.cos(angle) * size * 0.1;
      final y = center.dy + math.sin(angle) * size * 0.1;
      canvas.drawCircle(
        Offset(x, y),
        size * 0.02,
        Paint()..color = Colors.orange.shade200.withOpacity(opacity * 1.2),
      );
    }
  }

  void _drawLotusLeaf(Canvas canvas, Offset center, double size, double opacity) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF2D7A4F).withOpacity(opacity);

    final path = Path();
    
    // Vẽ hình lá sen tròn với rãnh ở giữa
    path.moveTo(center.dx, center.dy - size);
    
    // Nửa bên phải
    path.quadraticBezierTo(
      center.dx + size * 0.9, center.dy - size * 0.7,
      center.dx + size, center.dy,
    );
    path.quadraticBezierTo(
      center.dx + size * 0.9, center.dy + size * 0.7,
      center.dx, center.dy + size,
    );
    
    // Rãnh ở giữa
    path.lineTo(center.dx, center.dy);
    
    // Nửa bên trái
    path.moveTo(center.dx, center.dy - size);
    path.quadraticBezierTo(
      center.dx - size * 0.9, center.dy - size * 0.7,
      center.dx - size, center.dy,
    );
    path.quadraticBezierTo(
      center.dx - size * 0.9, center.dy + size * 0.7,
      center.dx, center.dy + size,
    );
    path.lineTo(center.dx, center.dy);

    canvas.drawPath(path, paint);

    // Vẽ gân lá
    final veinPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = const Color(0xFF1B5A37).withOpacity(opacity * 0.8);

    // Gân chính
    canvas.drawLine(
      Offset(center.dx, center.dy - size),
      Offset(center.dx, center.dy + size),
      veinPaint,
    );

    // Gân phụ
    for (int i = -3; i <= 3; i++) {
      if (i == 0) continue;
      final startY = center.dy + (i * size / 4);
      final endX = center.dx + (size * 0.7);
      canvas.drawLine(
        Offset(center.dx, startY),
        Offset(endX, startY + size * 0.1),
        veinPaint..strokeWidth = 1.0,
      );
      canvas.drawLine(
        Offset(center.dx, startY),
        Offset(center.dx - endX, startY + size * 0.1),
        veinPaint,
      );
    }
  }

  @override
  bool shouldRepaint(LotusPatternPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}