import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_constants.dart';

class ResultDialog extends StatelessWidget {
  final int percentage;
  final bool isPassed;
  final int correctAnswers;
  final int totalQuestions;
  final VoidCallback onComplete;

  const ResultDialog({
    super.key,
    required this.percentage,
    required this.isPassed,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final color = isPassed ? AppColors.bamboo1 : AppColors.vietnamRed;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 380),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.xLarge),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ResultHeader(isPassed: isPassed, color: color),
            _ResultBody(
              percentage: percentage,
              isPassed: isPassed,
              color: color,
              correctAnswers: correctAnswers,
              totalQuestions: totalQuestions,
              onComplete: onComplete,
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultHeader extends StatelessWidget {
  final bool isPassed;
  final Color color;

  const _ResultHeader({required this.isPassed, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: AppPadding.xxLarge,
        left: AppPadding.xxLarge,
        right: AppPadding.xxLarge,
        bottom: AppPadding.xLarge,
      ),
      child: Column(
        children: [
          Lottie.asset(
            isPassed ? AppAssets.passAnimation : AppAssets.errorAnimation,
            height: 200,
            width: 200,
            repeat: false,
          ),
          const SizedBox(height: AppPadding.small),
          Text(
            isPassed ? 'Xuất sắc!' : 'Cố gắng lên!',
            style: TextStyle(
              color: color,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppPadding.small),
          Text(
            isPassed
                ? 'Bạn đã vượt qua bài kiểm tra!'
                : 'Hãy thử lại để đạt kết quả tốt hơn',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color.withOpacity(0.95),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultBody extends StatelessWidget {
  final int percentage;
  final bool isPassed;
  final Color color;
  final int correctAnswers;
  final int totalQuestions;
  final VoidCallback onComplete;

  const _ResultBody({
    required this.percentage,
    required this.isPassed,
    required this.color,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.xxLarge),
      child: Column(
        children: [
          _ScoreCircle(percentage: percentage, color: color),
          const SizedBox(height: AppPadding.xLarge),
          _StatsCard(
            correctAnswers: correctAnswers,
            totalQuestions: totalQuestions,
          ),
          const SizedBox(height: AppPadding.xLarge),
          _CompleteButton(color: color, onTap: onComplete),
        ],
      ),
    );
  }
}

class _ScoreCircle extends StatelessWidget {
  final int percentage;
  final Color color;

  const _ScoreCircle({required this.percentage, required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 160,
          width: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.08),
          ),
        ),
        SizedBox(
          height: 140,
          width: 140,
          child: CircularProgressIndicator(
            value: percentage / 100,
            strokeWidth: 12,
            backgroundColor: Colors.grey.withOpacity(0.15),
            valueColor: AlwaysStoppedAnimation(color),
            strokeCap: StrokeCap.round,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: color,
                height: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'điểm số',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatsCard extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const _StatsCard({
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.large,
        vertical: AppPadding.medium,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(AppRadius.large),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatItem(
            icon: Icons.check_circle_rounded,
            label: 'Đúng',
            value: '$correctAnswers',
            color: AppColors.bamboo1,
          ),
          _VerticalDivider(),
          _StatItem(
            icon: Icons.cancel_rounded,
            label: 'Sai',
            value: '${totalQuestions - correctAnswers}',
            color: AppColors.vietnamRed,
          ),
          _VerticalDivider(),
          _StatItem(
            icon: Icons.format_list_numbered_rounded,
            label: 'Tổng',
            value: '$totalQuestions',
            color: Colors.blue[600]!,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 26),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
            height: 1,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 45, width: 1, color: Colors.grey[300]);
  }
}

class _CompleteButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;

  const _CompleteButton({required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.large),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppRadius.medium),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home_rounded, color: Colors.white, size: 20),
                SizedBox(width: AppPadding.small),
                Text(
                  'Hoàn thành',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}