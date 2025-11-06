import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/blocs/Auth/auth_bloc.dart';

/// ========================
/// LOGO SECTION
/// ========================
class LogoSection extends StatelessWidget {
  final Animation<double> logoScale;
  final Animation<double> logoOpacity;
  final AppLocalizations l10n;

  const LogoSection({
    super.key,
    required this.logoScale,
    required this.logoOpacity,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: logoOpacity,
      child: ScaleTransition(
        scale: logoScale,
        child: Column(
          children: [
            _buildLogoCircle(),
            const SizedBox(height: 32),
            Text(
              l10n.translWelcome,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFD4AF37),
                fontSize: 36,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                shadows: [Shadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 4)],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: const Text(
                "🎋 Học Tiếng Việt Cùng Nhau",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoCircle() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFD4AF37).withOpacity(0.2),
        border: Border.all(color: const Color(0xFFD4AF37), width: 3),
        boxShadow: [BoxShadow(color: const Color(0xFFD4AF37).withOpacity(0.4), blurRadius: 30, spreadRadius: 5)],
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
        ),
        child: Image.asset(AppAssets.logo, height: 100, width: 100),
      ),
    );
  }
}
