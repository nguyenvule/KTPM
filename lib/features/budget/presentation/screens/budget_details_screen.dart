import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moneynest/core/components/buttons/custom_icon_button.dart';
import 'package:moneynest/core/components/scaffolds/custom_scaffold.dart';
import 'package:moneynest/core/constants/app_spacing.dart';
import 'package:moneynest/features/budget/presentation/components/budget_card.dart';
import 'package:moneynest/features/budget/presentation/components/budget_date_card.dart';
import 'package:moneynest/features/budget/presentation/components/budget_fund_source_card.dart';
import 'package:moneynest/features/budget/presentation/components/budget_top_transactions_holder.dart';

class BudgetDetailsScreen extends StatelessWidget {
  const BudgetDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      context: context,
      title: 'Báo cáo ngân sách',
      showBackButton: true,
      actions: [
        CustomIconButton(
          onPressed: () {},
          icon: HugeIcons.strokeRoundedEdit01,
        ),
        CustomIconButton(
          onPressed: () {},
          icon: HugeIcons.strokeRoundedDelete01,
        ),
      ],
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.spacing20),
        child: Column(
          children: [
            BudgetCard(),
            Gap(AppSpacing.spacing12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: BudgetDateCard()),
                Gap(AppSpacing.spacing12),
                Expanded(child: BudgetFundSourceCard()),
              ],
            ),
            Gap(AppSpacing.spacing12),
            BudgetTopTransactionsHolder(),
          ],
        ),
      ),
    );
  }
}
