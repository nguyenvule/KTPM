import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:moneynest/core/constants/app_spacing.dart';
import 'package:moneynest/core/router/routes.dart';
import 'package:moneynest/features/budget/presentation/components/edit_monthly_budget_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final monthlyBudgetProvider = StateProvider<double>((ref) => 10000000);

class BudgetCardHolder extends ConsumerWidget {
  const BudgetCardHolder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlyBudget = ref.watch(monthlyBudgetProvider);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.spacing20),
      child: EditMonthlyBudgetCard(
        initialBudget: monthlyBudget,
        onBudgetChanged: (value) {
          ref.read(monthlyBudgetProvider.notifier).state = value;
        },
      ),
    );
  }
}
