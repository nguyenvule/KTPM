import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moneynest/core/components/progress_indicators/progress_bar.dart';
import 'package:moneynest/core/constants/app_colors.dart';
import 'package:moneynest/core/constants/app_radius.dart';
import 'package:moneynest/core/constants/app_spacing.dart';
import 'package:moneynest/core/constants/app_text_styles.dart';
import 'package:moneynest/features/category/data/repositories/category_repo.dart';
import 'package:moneynest/features/category_picker/presentation/components/category_tile.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacing12),
      decoration: BoxDecoration(
        color: AppColors.light,
        borderRadius: BorderRadius.circular(AppRadius.radius8),
        border: Border.all(color: AppColors.darkAlpha10),
      ),
      child: Column(
        children: [
          CategoryTile(
            category: categories.first,
            suffixIcon: HugeIcons.strokeRoundedArrowRight01,
          ),
          Gap(AppSpacing.spacing8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('155.000 left', style: AppTextStyles.body4),
              Text(
                '345.000 of 500.000',
                textAlign: TextAlign.right,
                style: AppTextStyles.body4,
              ),
            ],
          ),
          Gap(AppSpacing.spacing8),
          ProgressBar(value: 0.52, foreground: AppColors.purpleAlpha50),
        ],
      ),
    );
  }
}
