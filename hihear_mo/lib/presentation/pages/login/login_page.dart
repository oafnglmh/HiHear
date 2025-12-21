import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/blocs/Auth/auth_bloc.dart';
import 'package:hihear_mo/presentation/pages/login/widget/login_buttons_widget.dart';
import 'package:hihear_mo/presentation/pages/login/widget/logo_section_widget.dart';
import 'dart:math' as math;

import '../../painter/lotus_pattern_painter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late final AnimationController _logoCtrl;
  late final AnimationController _buttonsCtrl;
  late final AnimationController _lotusCtrl;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<Offset> _buttonsSlide;
  late final Animation<double> _buttonsOpacity;

  @override
  void initState() {
    super.initState();

    _logoCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _buttonsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _lotusCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);

    _logoScale = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoCtrl, curve: Curves.elasticOut));
    _logoOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoCtrl, curve: const Interval(0.0, 0.5)),
    );
    _buttonsSlide = Tween(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _buttonsCtrl, curve: Curves.easeOutCubic),
        );
    _buttonsOpacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _buttonsCtrl, curve: Curves.easeIn));

    _logoCtrl.forward();
    Future.delayed(const Duration(milliseconds: 500), _buttonsCtrl.forward);
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _buttonsCtrl.dispose();
    _lotusCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (user) {
            context.go(user.national != null ? '/home' : '/goalSelector');
          },

          error: (msg) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(msg),
              backgroundColor: const Color(0xFFDA251C),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              const _LoginBackground(),
              AnimatedBuilder(
                animation: _lotusCtrl,
                builder: (_, __) => CustomPaint(
                  painter: LotusPatternPainter(
                    animationValue: _lotusCtrl.value,
                  ),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      LogoSection(
                        logoScale: _logoScale,
                        logoOpacity: _logoOpacity,
                        l10n: l10n,
                      ),
                      const SizedBox(height: 60),
                      LoginButtons(
                        slide: _buttonsSlide,
                        opacity: _buttonsOpacity,
                        l10n: l10n,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LoginBackground extends StatelessWidget {
  const _LoginBackground();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A5C36), Color(0xFF1B7F4E), Color(0xFF0D4D2D)],
        ),
      ),
    );
  }
}
