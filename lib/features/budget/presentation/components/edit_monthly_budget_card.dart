import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynest/core/constants/app_colors.dart';
import 'package:moneynest/core/constants/app_radius.dart';
import 'package:moneynest/core/constants/app_spacing.dart';
import 'package:moneynest/core/constants/app_text_styles.dart';

import 'package:moneynest/features/budget/presentation/components/budget_card_holder.dart';
import 'package:moneynest/features/transaction/presentation/riverpod/current_month_expense_provider.dart';
import 'package:moneynest/features/wallet/riverpod/wallet_providers.dart';

class EditMonthlyBudgetCard extends ConsumerWidget {
  final double initialBudget;
  final void Function(double) onBudgetChanged;

  const EditMonthlyBudgetCard({
    super.key,
    required this.initialBudget,
    required this.onBudgetChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: initialBudget.toStringAsFixed(0));
    final expenseAsync = ref.watch(currentMonthExpenseProvider);
    final walletsAsync = ref.watch(allWalletsStreamProvider);

    double totalWalletBalance = 0;
    if (walletsAsync is AsyncData) {
      totalWalletBalance = walletsAsync.value?.fold<double>(0, (sum, w) => sum + (w.balance ?? 0)) ?? 0;
    }

    double currentMonthExpense = 0;
    if (expenseAsync is AsyncData) {
      currentMonthExpense = expenseAsync.value ?? 0;
    }

    String? errorText;
    double parsed = double.tryParse(controller.text.replaceAll('.', '')) ?? initialBudget;
    bool isValid = parsed >= currentMonthExpense && parsed <= totalWalletBalance;
    if (!isValid) {
      if (parsed < currentMonthExpense) {
        errorText = 'Số tiền phải lớn hơn hoặc bằng tổng chi tiêu (${currentMonthExpense.toStringAsFixed(0)})';
      } else if (parsed > totalWalletBalance) {
        errorText = 'Số tiền phải nhỏ hơn hoặc bằng tổng ngân sách (${totalWalletBalance.toStringAsFixed(0)})';
      }
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        color: AppColors.tertiary50,
        border: Border.all(color: AppColors.tertiaryAlpha25),
        borderRadius: BorderRadius.circular(AppRadius.radius8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Số tiền chi tiêu 1 tháng', style: AppTextStyles.body4.copyWith(color: AppColors.tertiary900)),
          const SizedBox(height: AppSpacing.spacing8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nhập số tiền',
                  ),
                  style: AppTextStyles.numericMedium,
                  onChanged: (value) {
                    final parsed = double.tryParse(value.replaceAll('.', '')) ?? initialBudget;
                    onBudgetChanged(parsed);
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.spacing8),
              ElevatedButton(
                onPressed: isValid
                    ? () {
                        final parsed = double.tryParse(controller.text.replaceAll('.', '')) ?? initialBudget;
                        onBudgetChanged(parsed);
                        FocusScope.of(context).unfocus();
                      }
                    : null,
                child: const Text('Lưu'),
              ),
            ],
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                errorText,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
