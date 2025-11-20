import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';

class FeedbackBottomSheet extends StatelessWidget {
  final bool isCorrect;
  final String explanation;
  final VoidCallback onNext;

  const FeedbackBottomSheet({
    super.key,
    required this.isCorrect,
    required this.explanation,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            isCorrect ? AppAssets.passAnimation : AppAssets.errorAnimation,
            height: 150,
            width: 150,
            repeat: false,
          ),
          const SizedBox(height: 16),
          Text(
            isCorrect ? 'Chính xác!' : 'Sai rồi!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isCorrect ? AppColors.bamboo1 : AppColors.vietnamRed,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            explanation,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
            ),
            child: const Text(
              'Tiếp tục',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}