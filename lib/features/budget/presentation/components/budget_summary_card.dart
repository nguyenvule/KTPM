import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moneynest/core/components/progress_indicators/progress_bar.dart';
import 'package:moneynest/core/constants/app_colors.dart';
import 'package:moneynest/core/constants/app_radius.dart';
import 'package:moneynest/core/constants/app_spacing.dart';
import 'package:moneynest/core/constants/app_text_styles.dart';
import 'package:moneynest/features/budget/presentation/components/budget_spent_card.dart';
import 'package:moneynest/features/budget/presentation/components/budget_card_holder.dart';
import 'package:moneynest/features/budget/presentation/components/budget_total_card.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynest/features/transaction/presentation/riverpod/current_month_expense_provider.dart';

class BudgetSummaryCard extends ConsumerWidget {
  const BudgetSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing20,
      ),
      padding: const EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        color: AppColors.tertiary50,
        border: Border.all(color: AppColors.tertiaryAlpha25),
        borderRadius: BorderRadius.circular(AppRadius.radius8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const Text(
                'Tổng ngân sách còn lại',
                style: AppTextStyles.body4,
              ),
              Consumer(
                builder: (context, ref, _) {
                  final expenseAsync = ref.watch(currentMonthExpenseProvider);
                  final monthlyBudget = ref.watch(monthlyBudgetProvider);
                  return expenseAsync.when(
                    data: (expense) {
                      final double remaining = (monthlyBudget - expense).clamp(0, double.infinity);
                      final formatted = remaining.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.');
                      return Text(
                        formatted,
                        style: AppTextStyles.numericHeading.copyWith(
                          color: AppColors.primary,
                        ),
                      );
                    },
                    loading: () => const SizedBox(height: 32, child: Center(child: CircularProgressIndicator(strokeWidth: 2))),
                    error: (e, _) => Text('Lỗi', style: AppTextStyles.numericHeading.copyWith(color: AppColors.primary)),
                  );
                },
              ),
            ],
          ),
          Consumer(
            builder: (context, ref, _) {
              final expenseAsync = ref.watch(currentMonthExpenseProvider);
              final monthlyBudget = ref.watch(monthlyBudgetProvider);
              return expenseAsync.when(
                data: (expense) {
                  double percent = 0.01;
                  if (monthlyBudget > 0) {
                    percent = (expense / monthlyBudget).clamp(0.01, 1.0);
                  }
                  return ProgressBar(value: percent);
                },
                loading: () => const ProgressBar(value: 0.01),
                error: (e, _) => const ProgressBar(value: 0.01),
              );
            },
          ),
          const Gap(AppSpacing.spacing12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: BudgetTotalCard()),
              Gap(AppSpacing.spacing12),
              Expanded(child: BudgetSpentCard()),
            ],
          ),
        ],
      ),
    );
  }
}
