import 'package:flutter/material.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          l10n.aboutTitle,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 125, 3),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(AppAssets.logo),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              l10n.aboutAppName,
              style: AppTextStyles.title.copyWith(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            Text(
              l10n.aboutVersion,
              style: AppTextStyles.body.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 24),

            Text(
              l10n.aboutDescription,
              style: AppTextStyles.body.copyWith(
                color: Colors.white,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    Icons.developer_mode,
                    l10n.aboutDeveloper,
                    l10n.aboutDeveloperValue,
                  ),
                  const SizedBox(height: 10),
                  _buildInfoRow(
                    Icons.email_outlined,
                    l10n.aboutEmail,
                    l10n.aboutEmailValue,
                  ),
                  const SizedBox(height: 10),
                  _buildInfoRow(
                    Icons.public,
                    l10n.aboutWebsite,
                    l10n.aboutWebsiteValue,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 190),
            Divider(color: Colors.white24),
            const SizedBox(height: 8),

            Text(
              l10n.aboutCopyright,
              style: AppTextStyles.body.copyWith(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.body.copyWith(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
              Text(
                value,
                style: AppTextStyles.body.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
