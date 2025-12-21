import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/blocs/Auth/auth_bloc.dart';
import 'package:hihear_mo/presentation/pages/login/widget/guest_button_widget.dart';
import 'package:hihear_mo/presentation/pages/login/widget/loading_indicator_widget.dart';
import 'package:hihear_mo/presentation/pages/login/widget/social_button_widget.dart';

class LoginButtons extends StatelessWidget {
  final Animation<Offset> slide;
  final Animation<double> opacity;
  final AppLocalizations l10n;
  final bool isLoading;

  const LoginButtons({
    super.key,
    required this.slide,
    required this.opacity,
    required this.l10n,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(
        position: slide,
        child: Column(
          children: [
            SocialButton(
              onPressed: isLoading
                  ? null
                  : () => context.read<AuthBloc>().add(
                      const AuthEvent.loginWithGoogle(),
                    ),
              icon: Image.asset(AppAssets.googleIcon, height: 28, width: 28),
              label: l10n.translLoginGg,
              backgroundColor: Colors.white,
              textColor: const Color(0xFF333333),
            ),
            const SizedBox(height: 16),
            SocialButton(
              onPressed: isLoading
                  ? null
                  : () => context.read<AuthBloc>().add(
                      const AuthEvent.loginWithFacebook(),
                    ),
              icon: const Icon(Icons.facebook, color: Colors.white, size: 28),
              label: l10n.translLoginFb,
              backgroundColor: const Color(0xFF1877F2),
              textColor: Colors.white,
            ),
            const SizedBox(height: 24),
            _DividerWithText(text: l10n.loginDividerOr),
            const SizedBox(height: 24),
            const GuestButton(),
            if (isLoading) ...[
              const SizedBox(height: 32),
              const LoadingIndicator(),
            ],
          ],
        ),
      ),
    );
  }
}

class _DividerWithText extends StatelessWidget {
  final String text;
  const _DividerWithText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: const Color(0xFFFFCD00).withOpacity(0.4),
            thickness: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFFFFCD00),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: const Color(0xFFFFCD00).withOpacity(0.4),
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
