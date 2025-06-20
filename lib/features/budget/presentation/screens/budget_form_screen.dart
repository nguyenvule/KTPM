import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moneynest/core/components/buttons/custom_icon_button.dart';
import 'package:moneynest/core/components/buttons/primary_button.dart';
import 'package:moneynest/core/components/form_fields/custom_confirm_checkbox.dart';
import 'package:moneynest/core/components/form_fields/custom_numeric_field.dart';
import 'package:moneynest/core/components/form_fields/custom_select_field.dart';
import 'package:moneynest/core/components/form_fields/custom_text_field.dart';
import 'package:moneynest/core/components/scaffolds/custom_scaffold.dart';
import 'package:moneynest/core/constants/app_colors.dart';
import 'package:moneynest/core/constants/app_spacing.dart';
import 'package:moneynest/core/router/routes.dart';
import 'package:moneynest/features/budget/presentation/components/budget_date_range_picker.dart';

class BudgetFormScreen extends StatelessWidget {
  const BudgetFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      context: context,
      title: 'Chỉnh sửa ngân sách',
      showBackButton: true,
      showBalance: false,
      actions: [
        CustomIconButton(
          onPressed: () {},
          icon: HugeIcons.strokeRoundedDelete01,
          color: AppColors.red,
          borderColor: AppColors.redAlpha10,
          backgroundColor: AppColors.redAlpha10,
        ),
      ],
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.spacing20),
            child: Column(
              children: [
                CustomTextField(
                  // controller: titleController,
                  label: 'Fund Source',
                  hint: 'Primary Wallet',
                  prefixIcon: HugeIcons.strokeRoundedWallet01,
                  readOnly: true,
                ),
                const Gap(AppSpacing.spacing16),
                CustomSelectField(
                  label: 'Category',
                  hint: 'Groceries • Cosmetics',
                  isRequired: true,
                  prefixIcon: HugeIcons.strokeRoundedPackage,
                  onTap: () {
                    context.push(Routes.categoryList);
                  },
                ),
                const Gap(AppSpacing.spacing16),
                const CustomNumericField(
                  // controller: amountController,
                  label: 'Amount',
                  hint: '\$ 34',
                  icon: HugeIcons.strokeRoundedCoins01,
                  isRequired: true,
                ),
                const Gap(AppSpacing.spacing16),
                const BudgetDateRangePicker(),
                const Gap(AppSpacing.spacing16),
                const CustomConfirmCheckbox(
                  title: 'Mark this budget as routine',
                  subtitle: 'No need to create this budget every time.',
                  checked: false,
                )
              ],
            ),
          ),
          PrimaryButton(
            label: 'Save',
            onPressed: () {},
          ).floatingBottom
        ],
      ),
    );
  }
}
