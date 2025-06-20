import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moneynest/core/constants/app_colors.dart';
import 'package:moneynest/core/constants/app_radius.dart';
import 'package:moneynest/core/constants/app_spacing.dart';
import 'package:moneynest/core/constants/app_text_styles.dart';

class ButtonChip extends StatelessWidget {
  final String label;
  final bool active;
  final GestureTapCallback? onTap;
  const ButtonChip({
    super.key,
    required this.label,
    this.active = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: active ? AppColors.purple50 : null,
          border: Border.all(
            color: active ? AppColors.purpleAlpha10 : AppColors.neutralAlpha25,
          ),
          borderRadius: BorderRadius.circular(
            AppRadius.radiusFull,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.spacing8,
          AppSpacing.spacing8,
          AppSpacing.spacing12,
          AppSpacing.spacing8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              active
                  ? HugeIcons.strokeRoundedCheckmarkCircle01
                  : HugeIcons.strokeRoundedCircle,
              color: active ? AppColors.purple : AppColors.neutral400,
            ),
            const Gap(AppSpacing.spacing8),
            Text(label,
                style: AppTextStyles.body3.copyWith(
                  color: active ? AppColors.purple : AppColors.neutral700,
                ))
          ],
        ),
      ),
    );
  }
}
