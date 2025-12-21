import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';

class GuestButton extends StatelessWidget {
  const GuestButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          context.go('/home');
        },
        icon: const Icon(Icons.person_outline, size: 24, color: Color(0xFFFFCD00)),
        label: Text(
          l10n.guestButtonLabel,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          side: const BorderSide(color: Color(0xFFFFCD00), width: 2),
          elevation: 0,
        ),
      ),
    );
  }
}