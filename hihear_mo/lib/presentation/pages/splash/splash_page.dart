import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/data/datasources/sources/audio/audio_player_service.dart';
import 'package:hihear_mo/domain/usecases/play_splash_music_usecase.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
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
  late Animation<double> _rotateAnimation;
  late Animation<double> _glowAnimation;
  late final AudioPlayerService _audioService;
  late final PlaySplashMusicUseCase _playMusicUseCase;
  @override
  void initState() {
    super.initState();
    _audioService = AudioPlayerService();
    _playMusicUseCase = PlaySplashMusicUseCase(_audioService);
    _playMusicUseCase();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _rotateAnimation = Tween<double>(
      begin: -0.1,
      end: 0.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticInOut));

    _glowAnimation = Tween<double>(
      begin: 0,
      end: 15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.orange.shade800,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotateAnimation.value,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: AppColors.bgWhite,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orangeAccent.withOpacity(0.6),
                        blurRadius: _glowAnimation.value,
                        spreadRadius: _glowAnimation.value / 2,
                      ),
                    ],
                  ),
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(AppAssets.logo),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
