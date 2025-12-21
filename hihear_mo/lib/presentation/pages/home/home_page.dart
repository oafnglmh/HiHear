import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/Services/streak_popup_service.dart';
import 'package:hihear_mo/core/constants/app_constants.dart';
import 'package:hihear_mo/presentation/painter/lotus_pattern_painter.dart';
import 'package:hihear_mo/presentation/painter/ripple_painter.dart';
import 'package:hihear_mo/share/UserShare.dart';
import 'package:hihear_mo/presentation/blocs/lesson/lesson_bloc.dart';
import 'package:hihear_mo/presentation/pages/home/widgets/floating_nav_bar.dart';
import 'package:hihear_mo/presentation/pages/home/widgets/streak_popup.dart';
import 'package:hihear_mo/presentation/pages/home/widgets/home_content.dart';
import 'package:hihear_mo/presentation/pages/speak/speak_page.dart';
import 'package:hihear_mo/presentation/pages/HearuAi/ai_chat_page.dart';
import 'package:hihear_mo/presentation/pages/saveVocab/saved_vocab_page.dart' hide RipplePainter, LotusPatternPainter;
import 'package:hihear_mo/presentation/pages/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late final AnimationController _navBarController;
  late final AnimationController _bambooController;
  late final AnimationController _lotusController;
  late final AnimationController _rippleController;
  int _selectedIndex = 0;
  final StreakPopupService _streakService = StreakPopupService();
  bool _hasCheckedPopup = false;

  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(const LessonEvent.loadLesson());
    _navBarController = AnimationController(vsync: this, duration: AppDuration.short);
    _bambooController = AnimationController(vsync: this, duration: AppDuration.bamboo)
      ..repeat(reverse: true);
    
    _lotusController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    if (!_hasCheckedPopup) {
      _hasCheckedPopup = true;
      _checkAndShowStreakPopup();
    }
  }

  Future<void> _checkAndShowStreakPopup() async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    if (!mounted) return;
    
    final userId = UserShare().id;
    if (userId == null || userId.isEmpty) {
      print('[HomePage] No userId found, skip popup');
      return;
    }
    
    print('[HomePage] Checking streak popup for user: $userId');
    
    final shouldShow = await _streakService.shouldShowPopup(userId);
    
    print('[HomePage] Should show popup: $shouldShow');
    
    if (shouldShow && mounted) {
      _showStreakPopup();
      await _streakService.markPopupShown(userId);
      print('[HomePage] Popup shown and marked');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _navBarController.dispose();
    _bambooController.dispose();
    _lotusController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    _navBarController.forward(from: 0);
    _pageController.animateToPage(
      index,
      duration: AppDuration.medium,
      curve: Curves.easeInOutCubic,
    );
  }

  void _showStreakPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (_) => StreakPopup(streakDays: UserShare().dailyStreak != null ? int.parse(UserShare().dailyStreak!) : 0)  ,

    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeContent(),
      const SpeakPage(),
      const AiChatPage(),
      const SavedVocabPage(),
      const ProfilePage(),
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
                    Color(0xFF0A5C36),
                    Color(0xFF1B7F4E),
                    Color(0xFF0D6B3D),
                    Color(0xFF0D4D2D),
                  ],
                ),
              ),
            ),
          ),

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

          AnimatedBuilder(
            animation: _rippleController,
            builder: (context, child) {
              return CustomPaint(
                painter: RipplePainter(
                  animationValue: _rippleController.value,
                ),
                size: Size.infinite,
              );
            },
          ),

          SafeArea(
            child: PageView(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (i) => setState(() => _selectedIndex = i),
              children: pages,
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: AppPadding.medium,
            child: FloatingNavBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}
