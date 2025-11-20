import 'package:flutter/material.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_constants.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';

class LessonHeader extends StatelessWidget {
  final double progress;
  final int currentIndex;
  final int totalQuestions;
  final int correctAnswers;
  final VoidCallback onClose;

  const LessonHeader({
    super.key,
    required this.progress,
    required this.currentIndex,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.large),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _CloseButton(onTap: onClose),
          const SizedBox(width: AppPadding.medium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Từ vựng cơ bản",
                  style: AppTextStyles.cardTitle.copyWith(fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Câu ${currentIndex + 1}/$totalQuestions',
                  style: AppTextStyles.cardDescription.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          _ScoreBadge(score: correctAnswers),
        ],
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CloseButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppPadding.small + 2),
        decoration: BoxDecoration(
          color: AppColors.bamboo1.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppRadius.medium),
        ),
        child: const Icon(Icons.close, color: AppColors.bamboo1, size: 22),
      ),
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  final int score;
  const _ScoreBadge({required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.medium,
        vertical: AppPadding.small - 1,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.goldLight, AppColors.goldDark],
        ),
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(
            '$score',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
