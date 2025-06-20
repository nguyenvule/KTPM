import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moneynest/core/components/buttons/button_state.dart';
import 'package:moneynest/core/components/buttons/button_type.dart';
import 'package:moneynest/core/components/loading_indicators/loading_indicator.dart';
import 'package:moneynest/core/constants/app_button_styles.dart';
import 'package:moneynest/core/constants/app_colors.dart';
import 'package:moneynest/core/constants/app_font_families.dart';
import 'package:moneynest/core/constants/app_spacing.dart';
import 'package:moneynest/core/constants/app_text_styles.dart';

class PrimaryButton extends FilledButton {
  PrimaryButton({
    required String label,
    bool isLoading = false,
    bool isOutlined = false,
    String loadingText = 'Please wait...',
    IconData? icon,
    EdgeInsets? padding,
    ButtonType type = ButtonType.primary,
    ButtonState state = ButtonState.active,
    VoidCallback? onPressed,
    super.key,
  }) : super(
         onPressed: isLoading ? null : onPressed,
         style:
             _styleFromTypeAndState(
               type: type,
               state: state,
               isLoading: isLoading,
             ).copyWith(
               textStyle: WidgetStatePropertyAll<TextStyle>(
                 AppTextStyles.heading6.copyWith(
                   fontFamily: AppFontFamilies.montserrat,
                 ),
               ),
               padding: padding == null
                   ? null
                   : WidgetStatePropertyAll<EdgeInsetsGeometry>(padding),
             ),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             if (isLoading)
               const SizedBox.square(
                 dimension: 16,
                 child: LoadingIndicator(color: Colors.grey),
               ),
             if (isLoading) const Gap(AppSpacing.spacing12),
             if (icon != null) Icon(icon),
             if (icon != null) const Gap(AppSpacing.spacing8),
             Text(isLoading ? loadingText : label),
           ],
         ),
       );

  static ButtonStyle _styleFromTypeAndState({
    ButtonType type = ButtonType.primary,
    ButtonState state = ButtonState.active,
    bool isLoading = false,
  }) {
    switch (type) {
      case ButtonType.primary:
        switch (state) {
          case ButtonState.active:
            if (isLoading) {
              return AppButtonStyles.primaryInactive;
            }
            return AppButtonStyles.primaryActive;
          case ButtonState.inactive:
            return AppButtonStyles.primaryInactive;
          case ButtonState.outlinedActive:
            if (isLoading) {
              return AppButtonStyles.primaryOutlinedInactive;
            }
            return AppButtonStyles.primaryOutlinedActive;
          case ButtonState.outlinedInactive:
            return AppButtonStyles.primaryOutlinedInactive;
        }
      case ButtonType.secondary:
        switch (state) {
          case ButtonState.active:
            if (isLoading) {
              return AppButtonStyles.secondaryInactive;
            }
            return AppButtonStyles.secondaryActive;
          case ButtonState.inactive:
            return AppButtonStyles.secondaryInactive;
          case ButtonState.outlinedActive:
            if (isLoading) {
              return AppButtonStyles.secondaryOutlinedInactive;
            }
            return AppButtonStyles.secondaryOutlinedActive;
          case ButtonState.outlinedInactive:
            return AppButtonStyles.secondaryOutlinedInactive;
        }
      case ButtonType.tertiary:
        switch (state) {
          case ButtonState.active:
            if (isLoading) {
              return AppButtonStyles.tertiaryInactive;
            }
            return AppButtonStyles.tertiaryActive;
          case ButtonState.inactive:
            return AppButtonStyles.tertiaryInactive;
          case ButtonState.outlinedActive:
            if (isLoading) {
              return AppButtonStyles.tertiaryOutlinedActive;
            }
            return AppButtonStyles.tertiaryOutlinedActive;
          case ButtonState.outlinedInactive:
            return AppButtonStyles.tertiaryOutlinedInactive;
        }
    }
  }
}

extension ButtonExtension on ButtonStyleButton {
  Widget get floatingBottom => Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      color: AppColors.light,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: this,
    ),
  );

  Widget floatingBottomWithContent({required Widget content}) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: AppColors.light,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(children: [content, this]),
      ),
    );
  }
}
