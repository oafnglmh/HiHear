import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/presentation/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class VocabCompletePage extends StatelessWidget {
  const VocabCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.9,
              child: Image.asset(AppAssets.celebrationGif, fit: BoxFit.fill),
            ),
          ),

          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 220,
                      child: Image.asset(
                        AppAssets.graduateGif,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 24),

                    Text(
                      " Chúc mừng bạn! ",
                      style: AppTextStyles.title.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textGold,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "Bạn đã hoàn thành toàn bộ bài học từ vựng!\nThật tuyệt vời! 🌟",
                      style: AppTextStyles.body.copyWith(
                        fontSize: 18,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),

                    ElevatedButton(
                      onPressed: () {
                        context.go('/home');
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 6,
                        backgroundColor: AppColors.gold,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 40,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        shadowColor: Colors.amberAccent.withOpacity(0.5),
                      ),
                      child: const Text(
                        "Trở về",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
