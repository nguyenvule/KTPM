import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynest/core/components/tabs/custom_tab.dart';
import 'package:moneynest/core/components/tabs/custom_tab_bar.dart';

class BudgetTabBar extends HookConsumerWidget {
  final TabController tabController;
  const BudgetTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context, ref) {
    return CustomTabBar(
      tabController: tabController,
      tabs: [
        CustomTab(label: 'Feb 2025'),
        CustomTab(label: 'Mar 2025'),
        CustomTab(label: "Apr 2025"),
        CustomTab(label: 'Tháng trước'),
        CustomTab(label: 'Tháng này'),
      ],
    );
  }
}
