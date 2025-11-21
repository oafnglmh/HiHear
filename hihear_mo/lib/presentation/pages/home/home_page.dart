import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_constants.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:hihear_mo/core/constants/category.dart';
import 'package:hihear_mo/core/helper/lesson_helper.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/blocs/lesson/lesson_bloc.dart';
import 'package:hihear_mo/presentation/pages/HearuAi/ai_chat_page.dart';
import 'package:hihear_mo/presentation/pages/profile/profile_page.dart';
import 'package:hihear_mo/presentation/pages/saveVocab/saved_vocab_page.dart';
import 'package:hihear_mo/presentation/pages/speak/speak_page.dart';
import 'package:hihear_mo/share/UserShare.dart';
import 'package:lottie/lottie.dart';
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
  bool _hasShownStreakPopup = false;

  @override
  void initState() {
    super.initState();
    _navBarController = AnimationController(
      vsync: this,
      duration: AppDuration.short,
    );
    _bambooController = AnimationController(
      vsync: this,
      duration: AppDuration.bamboo,
    )..repeat(reverse: true);
    context.read<LessonBloc>().add(const LessionEvent.loadLession());

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted && !_hasShownStreakPopup) {
        _showStreakPopup();
        _hasShownStreakPopup = true;
      }
    });
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
        duration: AppDuration.medium,
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _showStreakPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => const _StreakPopup(streakDays: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _HomeContent(),
      const SpeakPage(),
      const AiChatPage(),
      const SavedVocabPage(),
      ProfilePage(),
    ];

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          const _GradientBackground(),

          AnimatedBuilder(
            animation: _bambooController,
            builder: (context, child) => CustomPaint(
              painter: BambooPainter(animationValue: _bambooController.value),
              size: Size.infinite,
            ),
          ),

          SafeArea(
            child: PageView(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) => setState(() => _selectedIndex = index),
              children: pages,
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: AppPadding.medium,
            child: _FloatingNavBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}

// ========== STREAK POPUP ==========
class _StreakPopup extends StatefulWidget {
  final int streakDays;

  const _StreakPopup({required this.streakDays});

  @override
  State<_StreakPopup> createState() => _StreakPopupState();
}

class _StreakPopupState extends State<_StreakPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppPadding.xxLarge),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFE6F0), // hồng pastel rất nhẹ
                  Color(0xFFFFB6D5), // hồng đậm hơn
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(28)),
              boxShadow: [
                BoxShadow(
                  color: Colors.pinkAccent.withOpacity(0.3),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  AppAssets.streakAnimation,
                  width: 260,
                  height: 260,
                  fit: BoxFit.contain,
                  repeat: true,
                ),

                SizedBox(height: AppPadding.large),

                Text(
                  'Tuyệt vời! Tiếp tục phát huy nhé!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.cardDescription.copyWith(
                    color: Colors.pink.shade700,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: AppPadding.xLarge),

                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: AppPadding.large),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade400,
                      borderRadius: BorderRadius.circular(AppRadius.large),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.shade200.withOpacity(0.5),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Text(
                      'Tiếp tục học',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.button.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ========== BACKGROUND ==========
class _GradientBackground extends StatelessWidget {
  const _GradientBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.bamboo1, AppColors.bamboo2, AppColors.bamboo3],
          ),
        ),
      ),
    );
  }
}

// ========== NAVIGATION BAR ==========
class _FloatingNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const _FloatingNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        AppPadding.large,
        0,
        AppPadding.large,
        AppPadding.large,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.navBar),
        boxShadow: [
          BoxShadow(
            color: AppColors.goldLight.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.navBar),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(AppRadius.navBar),
              border: Border.all(
                color: AppColors.goldLight.withOpacity(0.3),
                width: 2,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.medium,
              vertical: AppPadding.medium,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  index: 0,
                  label: "Nhà",
                  isSelected: selectedIndex == 0,
                  onTap: () => onItemTapped(0),
                ),
                _NavItem(
                  icon: Icons.mic_rounded,
                  index: 1,
                  label: "Nói",
                  isSelected: selectedIndex == 1,
                  onTap: () => onItemTapped(1),
                ),
                _NavItem(
                  icon: Icons.smart_toy,
                  index: 2,
                  label: "HearAI",
                  isSelected: selectedIndex == 2,
                  onTap: () => onItemTapped(2),
                ),
                _NavItem(
                  icon: Icons.bookmark_rounded,
                  index: 3,
                  label: "Lưu",
                  isSelected: selectedIndex == 3,
                  onTap: () => onItemTapped(3),
                ),
                _NavItem(
                  icon: Icons.person_rounded,
                  index: 4,
                  label: "Hồ sơ",
                  isSelected: selectedIndex == 4,
                  onTap: () => onItemTapped(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.index,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDuration.short,
        curve: Curves.easeInOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.large,
          vertical: AppPadding.medium,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [AppColors.goldLight, AppColors.goldDark],
                )
              : null,
          borderRadius: BorderRadius.circular(AppRadius.large),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.goldLight.withOpacity(0.4),
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
              color: isSelected ? Colors.white : AppColors.textSecondary,
              size: AppSizes.iconSizeLarge,
            ),
            if (isSelected) ...[
              SizedBox(width: AppPadding.small),
              Text(label, style: AppTextStyles.button),
            ],
          ],
        ),
      ),
    );
  }
}

// ========== HOME CONTENT ==========
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
      duration: AppDuration.long,
    )..forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonBloc, LessonState>(
      builder: (context, state) {
        List<LessionEntity> lessons = [];
        state.maybeWhen(
          data: (data) => lessons = data,
          orElse: () => lessons = [],
        );

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: AppPadding.large),
                  _HeaderCard(controller: _headerController),
                  SizedBox(height: AppPadding.xxLarge),
                  const _ProgressCard(),
                  SizedBox(height: AppPadding.large),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.large),
              sliver: _LessonGrid(lessons: lessons),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        );
      },
    );
  }
}

// ========== HEADER CARD ==========
class _HeaderCard extends StatelessWidget {
  final AnimationController controller;

  const _HeaderCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.large),
        child: Container(
          padding: EdgeInsets.all(AppPadding.large),
          decoration: _cardDecoration(AppColors.goldLight),
          child: Row(
            children: [
              _VietnamFlagIcon(),
              SizedBox(width: AppPadding.large),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Xin chào! 👋", style: AppTextStyles.header),
                    SizedBox(height: AppPadding.small / 2),
                    Text(
                      "Học tiếng Việt thôi nào!",
                      style: AppTextStyles.subHeader,
                    ),
                  ],
                ),
              ),
              Image.asset(AppAssets.flowerIcon, fit: BoxFit.cover),
            ],
          ),
        ),
      ),
    );
  }
}

class _VietnamFlagIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.medium + 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.vietnamRed, AppColors.vietnamRedLight],
        ),
        borderRadius: BorderRadius.circular(AppRadius.large),
        boxShadow: [
          BoxShadow(
            color: AppColors.vietnamRed.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Text('🇻🇳', style: TextStyle(fontSize: 28)),
    );
  }
}

// ========== PROGRESS CARD ==========
class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.large),
      child: Container(
        padding: EdgeInsets.all(AppPadding.xxLarge),
        decoration: _cardDecoration(AppColors.goldLight),
        child: Column(
          children: [
            Row(
              children: [
                const _CircularProgress(),
                SizedBox(width: AppPadding.large),
                const Expanded(child: _ProgressInfo()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CircularProgress extends StatelessWidget {
  const _CircularProgress();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: AppSizes.progressCircle,
          width: AppSizes.progressCircle,
          child: const CircularProgressIndicator(
            value: 0.1,
            strokeWidth: 8,
            color: AppColors.vietnamRed,
            backgroundColor: AppColors.progressBackground,
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: AppColors.fireIcon,
                  size: AppSizes.iconSizeLarge,
                ),
                SizedBox(width: AppPadding.small / 2),
                Text("1", style: AppTextStyles.header),
              ],
            ),
            SizedBox(height: AppPadding.small / 4),
            Text("ngày", style: AppTextStyles.smallText),
          ],
        ),
      ],
    );
  }
}

class _ProgressInfo extends StatelessWidget {
  const _ProgressInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Chuỗi ngày học", style: AppTextStyles.cardDescription),
        SizedBox(height: AppPadding.small - 2),
        Text(
          "Tuyệt vời!",
          style: AppTextStyles.cardTitle.copyWith(
            color: AppColors.vietnamRed,
            fontSize: 20,
          ),
        ),
        SizedBox(height: AppPadding.small / 2),
        Text("Tiếp tục phát huy nhé!", style: AppTextStyles.cardDescription),
      ],
    );
  }
}

// ========== LESSON GRID ==========
class _LessonGrid extends StatelessWidget {
  final List<LessionEntity> lessons;

  const _LessonGrid({required this.lessons});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final lesson = lessons[index];
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 400 + (index * 100)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) => Transform.scale(
            scale: 0.8 + (value * 0.2),
            child: Opacity(
              opacity: value,
              child: _LessonCard(lesson: lesson),
            ),
          ),
        );
      }, childCount: lessons.length),
    );
  }
}

// ========== LESSON CARD với hiệu ứng xích ==========
class _LessonCard extends StatefulWidget {
  final LessionEntity lesson;

  const _LessonCard({required this.lesson});

  @override
  State<_LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<_LessonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _unlockController;
  late Animation<double> _shakeAnimation;
  late Animation<double> _lockFallAnimation;
  late Animation<double> _lockRotationAnimation;
  late Animation<double> _chainOpacityAnimation;
  bool isLocked = true;

  @override
  void initState() {
    super.initState();
    _unlockController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _unlockController,
        curve: const Interval(0.0, 0.2, curve: Curves.elasticIn),
      ),
    );

    _lockFallAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _unlockController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeInQuart),
      ),
    );

    _lockRotationAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(
        parent: _unlockController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeInQuart),
      ),
    );

    _chainOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _unlockController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );

    if (widget.lesson.id == '1' || widget.lesson.id == 1) {
      isLocked = false;
    }
  }

  @override
  void dispose() {
    _unlockController.dispose();
    super.dispose();
  }

  void _handleUnlock() {
    if (isLocked) {
      _unlockController.forward().then((_) {
        setState(() => isLocked = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = LessonHelper.getLessonColors(widget.lesson.id);
    final icon = LessonHelper.getIconForCategory(widget.lesson.category ?? '');

    return GestureDetector(
      onTap: isLocked ? _handleUnlock : () {},
      child: Stack(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isLocked ? 0.6 : 1.0,
            child: Container(
              decoration: _cardDecoration(isLocked ? Colors.grey : colors[0]),
              child: Padding(
                padding: EdgeInsets.all(AppPadding.medium + 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _LessonIcon(
                          icon: icon,
                          colors: isLocked
                              ? [Colors.grey.shade400, Colors.grey.shade600]
                              : colors,
                        ),
                        const Spacer(),
                        _LessonBadge(
                          title: widget.lesson.category ?? 'Bài học',
                          color: isLocked ? Colors.grey : colors[0],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      widget.lesson.title ?? 'Bài học',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.cardTitle.copyWith(
                        color: isLocked ? Colors.grey.shade600 : null,
                      ),
                    ),
                    SizedBox(height: AppPadding.small - 2),
                    Text(
                      widget.lesson.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.cardDescription.copyWith(
                        color: isLocked ? Colors.grey.shade500 : null,
                      ),
                    ),
                    SizedBox(height: AppPadding.medium + 2),
                    _StartButton(
                      l10n: l10n,
                      colors: isLocked
                          ? [Colors.grey.shade400, Colors.grey.shade600]
                          : colors,
                      lesson: widget.lesson,
                      isLocked: isLocked,
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (isLocked)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _unlockController,
                builder: (context, child) {
                  final shakeOffset = _shakeAnimation.value < 1
                      ? math.sin(_shakeAnimation.value * math.pi * 4) * 5
                      : 0.0;

                  return Transform.translate(
                    offset: Offset(shakeOffset, 0),
                    child: Opacity(
                      opacity: _chainOpacityAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(
                            AppRadius.xLarge + 4,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Transform.translate(
                                offset: Offset(
                                  0,
                                  _lockFallAnimation.value * 200,
                                ),
                                child: Transform.rotate(
                                  angle: _lockRotationAnimation.value * math.pi,
                                  child: Container(
                                    padding: EdgeInsets.all(AppPadding.large),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 15,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.lock_rounded,
                                      size: 40,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _LessonIcon extends StatelessWidget {
  final String icon;
  final List<Color> colors;

  const _LessonIcon({required this.icon, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.small + 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(AppRadius.medium),
        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(icon, style: const TextStyle(fontSize: 24)),
    );
  }
}

class _LessonBadge extends StatelessWidget {
  final String title;
  final Color color;

  const _LessonBadge({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.small + 2,
        vertical: AppPadding.small - 3,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppRadius.small),
      ),
      child: Text(title, style: AppTextStyles.smallText.copyWith(color: color)),
    );
  }
}

class _StartButton extends StatelessWidget {
  final AppLocalizations l10n;
  final List<Color> colors;
  final LessionEntity lesson;
  final bool isLocked;

  const _StartButton({
    required this.l10n,
    required this.colors,
    required this.lesson,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    final national = UserShare().national;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: AppPadding.small + 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(AppRadius.medium),
        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: isLocked
            ? null
            : () {
                if (lesson.category == Category.grammar) {
                  context.go('/grammar/${lesson.id}');
                } else if (lesson.category == Category.vocab) {
                  context.go('/vocab/${lesson.id}');
                }
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLocked ? 'Đã khóa' : l10n.startButton,
              style: AppTextStyles.button,
            ),
            SizedBox(width: AppPadding.small - 2),
            Icon(
              isLocked ? Icons.lock_rounded : Icons.arrow_forward_rounded,
              color: Colors.white,
              size: AppSizes.iconSizeSmall,
            ),
          ],
        ),
      ),
    );
  }
}

// ========== HELPER FUNCTION ==========
BoxDecoration _cardDecoration(Color borderColor) {
  return BoxDecoration(
    color: Colors.white.withOpacity(0.95),
    borderRadius: BorderRadius.circular(AppRadius.xLarge + 4),
    border: Border.all(color: borderColor.withOpacity(0.3), width: 2),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  );
}
