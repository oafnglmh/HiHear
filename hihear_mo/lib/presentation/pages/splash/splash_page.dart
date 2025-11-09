import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_constants.dart';
import 'package:hihear_mo/data/datasources/sources/audio/audio_player_service.dart';
import 'package:hihear_mo/domain/usecases/play_splash_music_usecase.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import '../../../core/constants/app_assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _logoRotateAnimation;
  late final AudioPlayerService _audioService;
  late final PlaySplashMusicUseCase _playMusicUseCase;

  @override
  void initState() {
    super.initState();
    _initAudio();
    _initAnimations();
    _startNavigation();
  }

  void _initAudio() {
    _audioService = AudioPlayerService();
    _playMusicUseCase = PlaySplashMusicUseCase(_audioService);
    _playMusicUseCase();
  }

  void _initAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _logoRotateAnimation = Tween<double>(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );

    _glowAnimation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  void _startNavigation() {
    Timer(const Duration(seconds: 3), _navigateToLogin);
  }

  void _navigateToLogin() {
    if (mounted) {
      _audioService.stop();
      context.go('/login');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _GradientBackground(),
        
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _AnimatedLogo(
                  scaleAnimation: _scaleAnimation,
                  fadeAnimation: _fadeAnimation,
                  rotateAnimation: _logoRotateAnimation,
                  glowAnimation: _glowAnimation,
                ),
                const SizedBox(height: 56),
                _LoadingIndicator(fadeAnimation: _fadeAnimation),
              ],
            ),
          ),
          
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: _BottomText(fadeAnimation: _fadeAnimation),
          ),
        ],
      ),
    );
  }
}

// ========== BACKGROUND ==========
class _GradientBackground extends StatelessWidget {
  const _GradientBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.bamboo1,
            AppColors.bamboo2,
            AppColors.bamboo3,
          ],
        ),
      ),
    );
  }
}

// ========== ANIMATED LOGO ==========
class _AnimatedLogo extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> fadeAnimation;
  final Animation<double> rotateAnimation;
  final Animation<double> glowAnimation;

  const _AnimatedLogo({
    required this.scaleAnimation,
    required this.fadeAnimation,
    required this.rotateAnimation,
    required this.glowAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: AnimatedBuilder(
        animation: rotateAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: rotateAnimation.value,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.goldLight.withOpacity(0.5),
                  width: 4,
                ),
                boxShadow: [
                  // Outer glow - Gold
                  BoxShadow(
                    color: AppColors.goldLight.withOpacity(0.6),
                    blurRadius: glowAnimation.value,
                    spreadRadius: glowAnimation.value / 2,
                  ),
                  // Inner shadow - depth
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.xLarge),
                  child: Image.asset(
                    AppAssets.logo,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ========== LOADING INDICATOR ==========
class _LoadingIndicator extends StatelessWidget {
  final Animation<double> fadeAnimation;

  const _LoadingIndicator({required this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SizedBox(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.goldLight,
          ),
          backgroundColor: Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }
}

// ========== BOTTOM TEXT ==========
class _BottomText extends StatelessWidget {
  final Animation<double> fadeAnimation;

  const _BottomText({required this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: Column(
        children: [
          Text(
            "Khám phá tiếng Việt cùng HiHear",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

}