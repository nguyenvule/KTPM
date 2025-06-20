import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moneynest/core/constants/app_colors.dart';
import 'package:moneynest/core/constants/app_radius.dart';
import 'package:moneynest/core/constants/app_spacing.dart';
import 'package:moneynest/core/router/routes.dart';
import 'package:moneynest/features/main/presentation/components/custom_bottom_app_bar.dart';
import 'package:moneynest/features/main/presentation/riverpod/main_page_view_riverpod.dart';

class DesktopSidebar extends ConsumerWidget {
  final PageController pageController;
  const DesktopSidebar({super.key, required this.pageController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: CustomBottomAppBar.desktopSidebarWidth, // Uses the updated width
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.spacing16,
        // horizontal: AppSpacing.spacing8, // ListTile will handle its own padding
      ),
      decoration: const BoxDecoration(color: AppColors.dark),
      child: Column(
        // Using ListView for scrollability if items exceed height
        // mainAxisAlignment: MainAxisAlignment.start, // Align items to the top
        // crossAxisAlignment: CrossAxisAlignment.stretch, // Make ListTiles fill width
        children: <Widget>[
          _buildSidebarItem(
            context: context,
            ref: ref,
            title: 'Home',
            icon: HugeIcons.strokeRoundedHome01,
            pageIndex: 0,
            onTap: () => pageController.jumpToPage(0),
          ),
          _buildSidebarItem(
            context: context,
            ref: ref,
            title: 'Transactions',
            icon: HugeIcons.strokeRoundedReceiptDollar,
            pageIndex: 1,
            onTap: () => pageController.jumpToPage(1),
          ),
          _buildSidebarItem(
            context: context,
            ref: ref,
            title: 'Analytics',
            icon: HugeIcons.strokeRoundedChart,
            pageIndex: 2,
            onTap: () => pageController.jumpToPage(2),
          ),
          _buildSidebarItem(
            context: context,
            ref: ref,
            title: 'Budgets',
            icon: HugeIcons.strokeRoundedDatabase,
            pageIndex: 3,
            onTap: () => pageController.jumpToPage(3),
          ),
          Spacer(),
          _buildSidebarItem(
            context: context,
            ref: ref,
            title: 'New Transaction',
            icon: HugeIcons.strokeRoundedAdd01,
            onTap: () {
              context.push(Routes.transactionForm);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    int? pageIndex,
    bool isSpecialAction = false,
  }) {
    final Color itemColor = isSpecialAction
        ? AppColors.primary
        : ref
              .read(pageControllerProvider.notifier)
              .getIconColor(pageIndex ?? -1);

    return ListTile(
      leading: Icon(icon, color: itemColor, size: 26),
      title: Text(
        title,
        style: TextStyle(
          color: itemColor,
          fontWeight:
              (pageIndex != null &&
                      ref.watch(pageControllerProvider) == pageIndex) ||
                  isSpecialAction
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing20,
        vertical: AppSpacing.spacing4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radius12),
      ),
      hoverColor: AppColors.light.withAlpha(10),
      selected:
          pageIndex != null && ref.watch(pageControllerProvider) == pageIndex,
      selectedTileColor: AppColors.primary.withAlpha(
        15,
      ), // Subtle selection indication
    );
  }
}
