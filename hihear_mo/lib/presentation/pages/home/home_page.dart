import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/blocs/Auth/auth_bloc.dart';
import 'package:hihear_mo/presentation/pages/lession/vocab_lesson_1_page.dart';
import 'package:hihear_mo/presentation/pages/profile/profile_page.dart';
import 'package:hihear_mo/presentation/pages/saveVocab/saved_vocab_page.dart';
import 'package:hihear_mo/presentation/pages/setting/setting_page.dart';
import 'package:hihear_mo/presentation/pages/speak/speak_page.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _navBarController;
  late AnimationController _bambooController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    
    _navBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _bambooController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _navBarController.dispose();
    _bambooController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() => _selectedIndex = index);
      _navBarController.forward(from: 0);
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _HomeContent(),
      const SpeakPage(),
      const SavedVocabPage(),
      ProfilePage(),
    ];

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF4A7C2C),
                    Color(0xFF5E9A3A),
                    Color(0xFF3D6624),
                  ],
                ),
              ),
            ),
          ),

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
            child: PageView(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) {
                setState(() => _selectedIndex = index);
              },
              children: pages,
            ),
          ),

          // Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: _buildFloatingNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingNavBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: const Color(0xFFD4AF37).withOpacity(0.3),
                width: 2,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_rounded, 0, "Trang chủ"),
                _buildNavItem(Icons.mic_rounded, 1, "Nói"),
                _buildNavItem(Icons.bookmark_rounded, 2, "Đã lưu"),
                _buildNavItem(Icons.person_rounded, 3, "Tài khoản"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, String label) {
    final bool isSelected = _selectedIndex == index;
    
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                )
              : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xFF666666),
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  const _HomeContent();

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _headerController;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildProgressCard(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: _buildLessonGrid(context),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 120),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return FadeTransition(
      opacity: _headerController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFFD4AF37).withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon cờ Việt Nam
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFDA291C), // Đỏ cờ Việt Nam
                      Color(0xFFFD0000),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFDA291C).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  '🇻🇳',
                  style: TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Xin chào! 👋",
                      style: TextStyle(
                        color: Color(0xFF2D5016),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Học tiếng Việt thôi nào!",
                      style: TextStyle(
                        color: const Color(0xFF2D5016).withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                
              ),
              Image.asset(
                AppAssets.flowerIcon,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFFD4AF37).withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Circular Progress với màu cờ đỏ
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: CircularProgressIndicator(
                        value: 0.1,
                        strokeWidth: 8,
                        color: const Color(0xFFDA291C),
                        backgroundColor: const Color(0xFFFFE0E0),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.local_fire_department,
                              color: Color(0xFFFF6B35),
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "1",
                              style: TextStyle(
                                color: Color(0xFF2D5016),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "ngày",
                          style: TextStyle(
                            color: const Color(0xFF2D5016).withOpacity(0.6),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(width: 20),
                
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chuỗi ngày học",
                        style: TextStyle(
                          color: const Color(0xFF2D5016).withOpacity(0.7),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Tuyệt vời!",
                        style: TextStyle(
                          color: Color(0xFFDA291C),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Tiếp tục phát huy nhé!",
                        style: TextStyle(
                          color: const Color(0xFF2D5016).withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.emoji_events,
                    color: Colors.white,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${l10n.level} 1 - Người mới",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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

  Widget _buildLessonGrid(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 400 + (index * 100)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: 0.8 + (value * 0.2),
                child: Opacity(
                  opacity: value,
                  child: _buildLessonCard(context, index + 1),
                ),
              );
            },
          );
        },
        childCount: 6,
      ),
    );
  }

  Widget _buildLessonCard(BuildContext context, int lessonId) {
    final l10n = AppLocalizations.of(context)!;
    final colors = _getLessonColors(lessonId);
    final icon = _getLessonIcon(lessonId);
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VocabLesson1Page()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: colors[0].withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: colors[0].withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Decorative pattern
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        colors[0].withOpacity(0.1),
                        colors[1].withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon và Badge
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: colors,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: colors[0].withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            icon,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: colors[0].withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Bài $lessonId",
                            style: TextStyle(
                              color: colors[0],
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    // Title
                    Text(
                      _getLessonTitle(lessonId),
                      style: const TextStyle(
                        color: Color(0xFF2D5016),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.article_outlined,
                          size: 14,
                          color: const Color(0xFF2D5016).withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "20 từ mới",
                          style: TextStyle(
                            color: const Color(0xFF2D5016).withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 14),
                    
                    // Start button
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: colors,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: colors[0].withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n.startButton,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Color> _getLessonColors(int lessonId) {
    final colorSets = [
      [const Color(0xFFDA291C), const Color(0xFFFD0000)], // Đỏ cờ VN
      [const Color(0xFFD4AF37), const Color(0xFFB8941E)], // Vàng gold
      [const Color(0xFF4A7C2C), const Color(0xFF5E9A3A)], // Xanh tre
      [const Color(0xFFFF6B35), const Color(0xFFFF8C50)], // Cam
      [const Color(0xFF667eea), const Color(0xFF764ba2)], // Tím
      [const Color(0xFF43e97b), const Color(0xFF38f9d7)], // Xanh mint
    ];
    return colorSets[(lessonId - 1) % colorSets.length];
  }

  String _getLessonIcon(int lessonId) {
    final icons = ['📚', '✍️', '🗣️', '👂', '🎯', '⭐'];
    return icons[(lessonId - 1) % icons.length];
  }

  String _getLessonTitle(int lessonId) {
    final titles = [
      'Từ vựng cơ bản',
      'Chào hỏi',
      'Gia đình',
      'Thức ăn',
      'Động vật',
      'Màu sắc',
    ];
    return titles[(lessonId - 1) % titles.length];
  }
}

// Bamboo Painter - vẽ cây tre
class BambooPainter extends CustomPainter {
  final double animationValue;

  BambooPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2D5016).withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Vẽ cây tre bên trái
    _drawBamboo(canvas, size, 30, paint, animationValue);
    // Vẽ cây tre bên phải
    _drawBamboo(canvas, size, size.width - 30, paint, -animationValue);
  }

  void _drawBamboo(Canvas canvas, Size size, double x, Paint paint, double sway) {
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
          ..color = const Color(0xFF6DB33F).withOpacity(0.15)
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