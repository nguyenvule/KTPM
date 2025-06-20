import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moneynest/core/constants/app_colors.dart';
import 'package:moneynest/core/constants/app_radius.dart';
import 'package:moneynest/core/constants/app_spacing.dart';
import 'package:moneynest/core/constants/app_text_styles.dart';
import 'package:moneynest/core/extensions/text_style_extensions.dart';

class SecondaryButton extends OutlinedButton {
  SecondaryButton({
    super.key,
    required super.onPressed,
    String? label,
    IconData? icon,
  }) : super(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(23.5),
              backgroundColor: AppColors.purple50,
              side: const BorderSide(color: AppColors.purpleAlpha10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.radius8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: AppColors.purple,
                    size: 22,
                  ),
                if (label != null) const Gap(AppSpacing.spacing8),
                if (label != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      label,
                      style: AppTextStyles.body3
                          .copyWith(
                            color: AppColors.purple,
                          )
                          .semibold,
                    ),
                  ),
              ],
            ));
}
