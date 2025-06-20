import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moneynest/core/components/buttons/custom_icon_button.dart';
import 'package:moneynest/core/constants/app_colors.dart';
import 'package:moneynest/core/constants/app_radius.dart';
import 'package:moneynest/core/constants/app_spacing.dart';
import 'package:moneynest/core/constants/app_text_styles.dart';
import 'package:moneynest/features/category/data/model/category_model.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;
  final double? height;
  final double? iconSize;
  final IconData? suffixIcon;
  final GestureTapCallback? onSuffixIconPressed;
  final Function(CategoryModel)? onSelectCategory;
  const CategoryTile({
    super.key,
    required this.category,
    this.onSuffixIconPressed,
    this.onSelectCategory,
    this.suffixIcon,
    this.height,
    this.iconSize = AppSpacing.spacing32,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelectCategory?.call(category),
      child: Container(
        height: height,
        padding: const EdgeInsets.all(AppSpacing.spacing4),
        decoration: BoxDecoration(
          color: AppColors.secondary50,
          borderRadius: BorderRadius.circular(AppRadius.radius8),
          border: Border.all(color: AppColors.secondaryAlpha10),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.spacing12),
              decoration: BoxDecoration(
                color: AppColors.secondaryAlpha10,
                borderRadius: BorderRadius.circular(AppRadius.radius8),
                border: Border.all(color: AppColors.secondaryAlpha10),
              ),
              child: Icon(HugeIcons.strokeRoundedPizza01, size: iconSize),
            ),
            const Gap(AppSpacing.spacing8),
            Expanded(child: Text(category.title, style: AppTextStyles.body3)),
            if (suffixIcon != null)
              CustomIconButton(
                onPressed: onSuffixIconPressed ?? () {},
                icon: suffixIcon!,
                iconSize: IconSize.small,
                visualDensity: VisualDensity.compact,
              ),
          ],
        ),
      ),
    );
  }
}
