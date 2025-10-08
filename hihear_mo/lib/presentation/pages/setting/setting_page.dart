import 'package:flutter/material.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/presentation/pages/setting/about_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Tài khoản"),
              _buildSettingItem(
                icon: Icons.person_outline,
                title: "Thông tin cá nhân",
                onTap: () {},
              ),
              _buildSettingItem(
                icon: Icons.logout,
                title: "Đăng xuất",
                onTap: () {},
              ),
              const SizedBox(height: 20),

              _buildSectionTitle("Ứng dụng"),
              _buildSettingItem(
                icon: Icons.language,
                title: "Ngôn ngữ",
                onTap: () {},
              ),
              _buildSettingItem(
                icon: Icons.notifications_outlined,
                title: "Thông báo",
                onTap: () {},
              ),
              const SizedBox(height: 20),

              _buildSectionTitle("Khác"),
              _buildSettingItem(
                icon: Icons.help_outline,
                title: "Trợ giúp & Hỗ trợ",
                onTap: () {},
              ),
              _buildSettingItem(
                icon: Icons.info_outline,
                title: "Giới thiệu ứng dụng",
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
