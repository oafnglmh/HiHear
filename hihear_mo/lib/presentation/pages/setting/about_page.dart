import 'package:flutter/material.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          "Giới thiệu ứng dụng",
          style: TextStyle(color: Color.fromARGB(255, 255, 125, 3)),
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
              "HiHear",
              style: AppTextStyles.title.copyWith(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Phiên bản 1.0.0",
              style: AppTextStyles.body.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 24),

            Text(
              "HiHear là ứng dụng hỗ trợ luyện nghe, học từ vựng và ngữ pháp tiếng Anh thông minh. "
              "Ứng dụng kết hợp trí tuệ nhân tạo để giúp người học cải thiện khả năng nghe – hiểu thông qua các bài học tương tác và phân tích giọng nói.",
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
                    "Nhà phát triển",
                    "HiHear Team",
                  ),
                  const SizedBox(height: 10),
                  _buildInfoRow(
                    Icons.email_outlined,
                    "Email hỗ trợ",
                    "hcassano.dev@gmail.com",
                  ),
                  const SizedBox(height: 10),
                  _buildInfoRow(Icons.public, "Website", "hihear.com"),
                ],
              ),
            ),
            const SizedBox(height: 190),
            Divider(color: Colors.white24),
            const SizedBox(height: 8),
            Text(
              "© 2025 HiHear. All rights reserved.",
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
