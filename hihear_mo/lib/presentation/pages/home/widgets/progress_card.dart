import 'package:flutter/material.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_constants.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.large),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.xxLarge),
        decoration: _cardDecoration(),
        child: const Row(
          children: [
            _CircularProgress(),
            SizedBox(width: AppPadding.large),
            Expanded(child: _ProgressInfo()),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.95),
      borderRadius: BorderRadius.circular(AppRadius.xLarge + 4),
      border: Border.all(color: AppColors.goldLight.withOpacity(0.3), width: 2),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 8)),
      ],
    );
  }
}

class _CircularProgress extends StatelessWidget {
  const _CircularProgress();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: AppSizes.progressCircle,
          width: AppSizes.progressCircle,
          child: const CircularProgressIndicator(
            value: 0.1, // Có thể thay bằng giá trị thực từ UserBloc sau
            strokeWidth: 8,
            color: AppColors.vietnamRed,
            backgroundColor: AppColors.progressBackground,
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.local_fire_department, color: AppColors.fireIcon, size: AppSizes.iconSizeLarge),
                const SizedBox(width: 4),
                Text("1", style: AppTextStyles.header.copyWith(fontSize: 32)),
              ],
            ),
            const SizedBox(height: 4),
            Text("ngày", style: AppTextStyles.smallText),
          ],
        ),
      ],
    );
  }
}

class _ProgressInfo extends StatelessWidget {
  const _ProgressInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Chuỗi ngày học", style: AppTextStyles.cardDescription),
        const SizedBox(height: 4),
        Text("Tuyệt vời!", style: AppTextStyles.cardTitle.copyWith(color: AppColors.vietnamRed, fontSize: 20)),
        const SizedBox(height: 4),
        Text("Tiếp tục phát huy nhé!", style: AppTextStyles.cardDescription),
      ],
    );
  }
}