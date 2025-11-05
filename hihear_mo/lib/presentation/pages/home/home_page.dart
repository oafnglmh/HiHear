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
  final bool isPremium;
  
  const HomePage({
    super.key,
    this.isPremium = true,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _navBarController;
  late AnimationController _shimmerController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    
    _navBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _navBarController.dispose();
    _shimmerController.dispose();
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
      _HomeContent(isPremium: widget.isPremium),
      SpeakPage(isPremium: widget.isPremium),
      SavedVocabPage(isPremium: widget.isPremium),
      ProfilePage(),
    ];

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: widget.isPremium
                ? Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF1a1a2e),
                          Color(0xFF16213e),
                          Color(0xFF0f3460),
                        ],
                      ),
                    ),
                  )
                : Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFF9F66),
                          Color(0xFFFF8C50),
                          Color(0xFFFFA976),
                        ],
                      ),
                    ),
                  ),
          ),
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
            color: widget.isPremium
                ? const Color(0xFFFFD700).withOpacity(0.3)
                : Colors.black.withOpacity(0.15),
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
              gradient: widget.isPremium
                  ? LinearGradient(
                      colors: [
                        const Color(0xFFFFD700).withOpacity(0.15),
                        const Color(0xFFFFA500).withOpacity(0.1),
                      ],
                    )
                  : null,
              color: widget.isPremium ? null : Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: widget.isPremium
                    ? const Color(0xFFFFD700).withOpacity(0.3)
                    : Colors.white.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_rounded, 0),
                _buildNavItem(Icons.mic_rounded, 1),
                _buildNavItem(Icons.bookmark_rounded, 2),
                _buildNavItem(Icons.person_rounded, 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final bool isSelected = _selectedIndex == index;
    
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        padding: EdgeInsets.all(isSelected ? 14 : 12),
        decoration: BoxDecoration(
          gradient: isSelected && widget.isPremium
              ? const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                )
              : null,
          color: isSelected && !widget.isPremium 
              ? const Color(0xFFFF8C50)
              : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: (widget.isPremium
                            ? const Color(0xFFFFD700)
                            : const Color(0xFFFF8C50))
                        .withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Icon(
          icon,
          color: isSelected
              ? Colors.white
              : (widget.isPremium
                  ? Colors.white.withOpacity(0.6)
                  : const Color(0xFF666666)),
          size: 24,
        ),
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  final bool isPremium;
  
  const _HomeContent({this.isPremium = false});

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
          child: SizedBox(height: 100),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return FadeTransition(
      opacity: _headerController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(widget.isPremium ? 0.2 : 0.95),
                borderRadius: BorderRadius.circular(16),
                boxShadow: widget.isPremium
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Icon(
                Icons.school_rounded,
                color: widget.isPremium ? Colors.white : const Color(0xFFFF8C50),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Xin chào! 👋",
                    style: TextStyle(
                      color: widget.isPremium ? Colors.white : Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Sẵn sàng học hôm nay?",
                    style: TextStyle(
                      color: widget.isPremium
                          ? Colors.white.withOpacity(0.8)
                          : Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            if (widget.isPremium) _buildPremiumBadge(),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD700).withOpacity(0.5),
            blurRadius: 8,
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.workspace_premium, color: Colors.white, size: 16),
          SizedBox(width: 4),
          Text(
            "PRO",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
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
          color: widget.isPremium
              ? Colors.white.withOpacity(0.1)
              : Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(24),
          border: widget.isPremium
              ? Border.all(
                  color: const Color(0xFFFFD700).withOpacity(0.3),
                )
              : null,
          boxShadow: widget.isPremium
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Circular Progress
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: CircularProgressIndicator(
                        value: 0.1,
                        strokeWidth: 8,
                        color: widget.isPremium
                            ? const Color(0xFFFFD700)
                            : const Color(0xFFFF8C50),
                        backgroundColor: widget.isPremium
                            ? Colors.white.withOpacity(0.2)
                            : const Color(0xFFFFE0D0),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: widget.isPremium
                                  ? const Color(0xFFFFD700)
                                  : const Color(0xFFFF6B35),
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "1",
                              style: TextStyle(
                                color: widget.isPremium
                                    ? Colors.white
                                    : const Color(0xFF333333),
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
                            color: widget.isPremium
                                ? Colors.white.withOpacity(0.7)
                                : const Color(0xFF999999),
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
                        "Streak hiện tại",
                        style: TextStyle(
                          color: widget.isPremium
                              ? Colors.white.withOpacity(0.8)
                              : const Color(0xFF666666),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Tuyệt vời!",
                        style: TextStyle(
                          color: widget.isPremium
                              ? const Color(0xFFFFD700)
                              : const Color(0xFFFF8C50),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Tiếp tục duy trì nhé!",
                        style: TextStyle(
                          color: widget.isPremium
                              ? Colors.white.withOpacity(0.7)
                              : const Color(0xFF999999),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Level Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: widget.isPremium
                    ? LinearGradient(
                        colors: [
                          const Color(0xFFFFD700).withOpacity(0.3),
                          const Color(0xFFFFA500).withOpacity(0.2),
                        ],
                      )
                    : const LinearGradient(
                        colors: [Color(0xFFFFE5D0), Color(0xFFFFF0E5)],
                      ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.emoji_events,
                    color: widget.isPremium
                        ? const Color(0xFFFFD700)
                        : const Color(0xFFFF8C50),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${l10n.level} 1",
                    style: TextStyle(
                      color: widget.isPremium
                          ? Colors.white
                          : const Color(0xFF333333),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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
        childCount: 4,
      ),
    );
  }

  Widget _buildLessonCard(BuildContext context, int lessonId) {
    final l10n = AppLocalizations.of(context)!;
    final colors = _getLessonColors(lessonId);
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VocabLesson1Page()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: widget.isPremium
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors,
                )
              : null,
          color: widget.isPremium ? null : Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(24),
          border: widget.isPremium
              ? Border.all(
                  color: colors[0].withOpacity(0.5),
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: widget.isPremium
                  ? colors[0].withOpacity(0.3)
                  : Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Background Image/Pattern
              if (!widget.isPremium)
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.05,
                    child: Image.asset(
                      AppAssets.englishBg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Lesson badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: widget.isPremium
                            ? Colors.white.withOpacity(0.2)
                            : colors[0].withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Bài $lessonId",
                        style: TextStyle(
                          color: widget.isPremium ? Colors.white : colors[0],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Title
                    Text(
                      "Từ vựng cơ bản",
                      style: TextStyle(
                        color: widget.isPremium ? Colors.white : const Color(0xFF333333),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.article_outlined,
                          size: 14,
                          color: widget.isPremium
                              ? Colors.white.withOpacity(0.8)
                              : const Color(0xFF999999),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "20 từ mới",
                          style: TextStyle(
                            color: widget.isPremium
                                ? Colors.white.withOpacity(0.8)
                                : const Color(0xFF999999),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Start button
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        gradient: widget.isPremium
                            ? null
                            : LinearGradient(
                                colors: [colors[0], colors[1]],
                              ),
                        color: widget.isPremium ? Colors.white : null,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: (widget.isPremium ? Colors.white : colors[0])
                                .withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n.startButton,
                            style: TextStyle(
                              color: widget.isPremium ? colors[0] : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: widget.isPremium ? colors[0] : Colors.white,
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
      [const Color(0xFF667eea), const Color(0xFF764ba2)],
      [const Color(0xFFf093fb), const Color(0xFFf5576c)],
      [const Color(0xFF4facfe), const Color(0xFF00f2fe)],
      [const Color(0xFF43e97b), const Color(0xFF38f9d7)],
    ];
    return colorSets[(lessonId - 1) % colorSets.length];
  }
}