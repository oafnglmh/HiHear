import 'package:flutter/material.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          loc.helpTitle,
          style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: AppColors.background,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(loc.helpUsageGuide),
            _buildHelpCard(
              icon: Icons.school_outlined,
              title: loc.helpStartLearning,
              description: loc.helpStartLearningDesc,
            ),
            _buildHelpCard(
              icon: Icons.book_outlined,
              title: loc.helpVocabManage,
              description: loc.helpVocabManageDesc,
            ),
            _buildHelpCard(
              icon: Icons.chat_bubble_outline,
              title: loc.helpSpeakAI,
              description: loc.helpSpeakAIDesc,
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(loc.helpFAQ),
            _buildFaqItem(
              question: loc.helpFAQInternetQ,
              answer: loc.helpFAQInternetA,
            ),
            _buildFaqItem(
              question: loc.helpFAQProgressQ,
              answer: loc.helpFAQProgressA,
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(loc.helpContact),
            _buildContactCard(
              icon: Icons.email_outlined,
              title: loc.helpContactEmail,
              value: "hcassano.dev@gmail.com",
              onTap: () {},
            ),
            _buildContactCard(
              icon: Icons.public_outlined,
              title: loc.helpContactWebsite,
              value: "hihear.com",
              onTap: () {},
            ),
            _buildContactCard(
              icon: Icons.phone_outlined,
              title: loc.helpContactHotline,
              value: "+84 384 252 407",
              onTap: () {},
            ),
            const SizedBox(height: 30),

            Center(
              child: Text(
                loc.helpSupportNote,
                style: AppTextStyles.body.copyWith(color: AppColors.background),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: AppTextStyles.title.copyWith(
          color: AppColors.background,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildHelpCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.title.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem({required String question, required String answer}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• $question",
            style: AppTextStyles.title.copyWith(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            answer,
            style: AppTextStyles.body.copyWith(
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
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
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
