import 'package:flutter/material.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_constants.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';

class HeaderCard extends StatelessWidget {
  final AnimationController controller;

  const HeaderCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.large),
        child: Container(
          padding: const EdgeInsets.all(AppPadding.large),
          decoration: _cardDecoration(),
          child: Row(
            children: [
              const _VietnamFlagIcon(),
              const SizedBox(width: AppPadding.large),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Xin chào!",
                      style: AppTextStyles.header.copyWith(
                        color: const Color(0xFF2D5016),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Học tiếng Việt thôi nào!",
                      style: AppTextStyles.subHeader.copyWith(
                        color: const Color(0xFF2D5016).withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(AppAssets.flowerIcon, width: 60, height: 60),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white.withOpacity(0.95), Colors.white.withOpacity(0.9)],
      ),
      borderRadius: BorderRadius.circular(AppRadius.xLarge + 4),
      border: Border.all(color: const Color(0xFFD4AF37), width: 3),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 25,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: const Color(0xFFD4AF37).withOpacity(0.3),
          blurRadius: 30,
          spreadRadius: -5,
          offset: const Offset(0, 15),
        ),
      ],
    );
  }
}

class _VietnamFlagIcon extends StatelessWidget {
  const _VietnamFlagIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.medium + 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFDA291C), Color(0xFFFD0000)],
        ),
        borderRadius: BorderRadius.circular(AppRadius.large),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDA291C).withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Text('🇻🇳', style: TextStyle(fontSize: 32)),
    );
  }
}
