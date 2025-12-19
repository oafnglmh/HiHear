import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/pages/Goal/goal_selector_page.dart';
import 'dart:math' as math;

import 'package:hihear_mo/presentation/pages/home/home_page.dart';
import 'package:hihear_mo/presentation/painter/ripple_painter.dart';

import '../../painter/lotus_pattern_painter.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {
  late AnimationController _lotusController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _floatingController;
  late AnimationController _rippleController;

  @override
  void initState() {
    super.initState();
    
    _lotusController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
  }

  @override
  void dispose() {
    _lotusController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _floatingController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient
          Container(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
              child: Column(
                children: [
                  const Spacer(),

                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _slideController,
                      curve: Curves.easeOutCubic,
                    )),
                    child: FadeTransition(
                      opacity: _fadeController,
                      child: Column(
                        children: [
                          _buildLanguageBadge(),
                          const SizedBox(height: 24),
                          _buildWelcomeCard(l10n),
                          const SizedBox(height: 32),
                          _buildCharacterImage(),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  _buildStartButton(l10n),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageBadge() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, math.sin(_floatingController.value * math.pi * 2) * 6),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFDA291C),
                  Color(0xFFFD0000),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFDA291C).withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '🇻🇳',
                  style: TextStyle(fontSize: 28),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Tiếng Việt',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Color(0xFFFFD700),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWelcomeCard(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.95),
            Colors.white.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFD4AF37),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: -5,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFD4AF37),
                  Color(0xFFB8941E),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD4AF37).withOpacity(0.4),
                  blurRadius: 15,
                ),
              ],
            ),
            child: const Icon(
              Icons.local_florist,
              color: Colors.white,
              size: 32,
            ),
          ),
          
          const SizedBox(height: 16),
          
          DefaultTextStyle(
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF2D5016),
              fontWeight: FontWeight.w600,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  l10n.journeyStartMessage,
                  speed: const Duration(milliseconds: 60),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 500),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterImage() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, math.sin(_floatingController.value * math.pi * 2 + 1) * 8),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.25),
                  Colors.white.withOpacity(0.15),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFD4AF37).withOpacity(0.5),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 220,
                  height: 170,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFD4AF37).withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                
                Image.asset(
                  AppAssets.welcomeGif,
                  height: 150,
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStartButton(AppLocalizations l10n) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (value * 0.2),
          child: Opacity(
            opacity: value,
            child: Container(
              width: double.infinity,
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.5),
                    blurRadius: 25,
                    spreadRadius: 2,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  context.go('/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.rocket_launch_rounded,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      l10n.startButton,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 28,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}