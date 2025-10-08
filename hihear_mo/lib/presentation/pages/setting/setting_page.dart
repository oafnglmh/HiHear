import 'package:flutter/material.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/presentation/pages/setting/about_page.dart';
import 'package:hihear_mo/presentation/pages/setting/help_page.dart';
import 'package:hihear_mo/presentation/pages/setting/language_setting_page.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(loc.settingAccountSection),
              _buildSettingItem(
                icon: Icons.person_outline,
                title: loc.settingPersonalInfo,
                onTap: () {},
              ),
              _buildSettingItem(
                icon: Icons.logout,
                title: loc.settingLogout,
                onTap: () {},
              ),
              const SizedBox(height: 20),

              _buildSectionTitle(loc.settingAppSection),
              _buildSettingItem(
                icon: Icons.language,
                title: loc.settingLanguage,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LanguageSettingPage(),
                    ),
                  );
                },
              ),
              _buildSettingItem(
                icon: Icons.notifications_outlined,
                title: loc.settingNotification,
                onTap: () {},
              ),
              const SizedBox(height: 20),

              _buildSectionTitle(loc.settingOtherSection),
              _buildSettingItem(
                icon: Icons.help_outline,
                title: loc.settingHelpSupport,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HelpPage()),
                  );
                },
              ),
              _buildSettingItem(
                icon: Icons.info_outline,
                title: loc.settingAboutApp,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: AppTextStyles.title.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24, width: 1),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.body.copyWith(color: Colors.white),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white70),
          ],
        ),
      ),
    );
  }
}
