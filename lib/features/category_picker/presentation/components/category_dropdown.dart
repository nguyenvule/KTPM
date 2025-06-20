import 'package:expandable/expandable.dart'
    show ExpandableController, ExpandablePanel, ExpandableThemeData;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useMemoized;

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moneynest/core/constants/app_spacing.dart';
import 'package:moneynest/core/utils/logger.dart';
import 'package:moneynest/features/category/data/model/category_model.dart';
import 'package:moneynest/features/category/presentation/screens/category_form_screen.dart';

import 'category_tile.dart';

class CategoryDropdown extends HookConsumerWidget {
  final bool isManageCategory;
  final CategoryModel category;
  const CategoryDropdown({
    super.key,
    this.isManageCategory = false,
    required this.category,
  });

  @override
  Widget build(BuildContext context, ref) {
    final expandableController = useMemoized(() => ExpandableController(), []);

    final List<CategoryModel> subCategories = category.subCategories ?? [];

    return ExpandablePanel(
      controller: expandableController,
      header: InkWell(
        onTap: () {
          expandableController.toggle();
        },
        child: CategoryTile(
          category: category,
          suffixIcon: expandableController.expanded
              ? HugeIcons.strokeRoundedArrowDown01
              : HugeIcons.strokeRoundedArrowRight01,
          onSelectCategory: (selectedCategory) {
            Log.d(selectedCategory.toJson(), label: 'category');
            // if picking category, then return to previous screen with selected category
            if (!isManageCategory) {
              context.pop(selectedCategory);
            }
          },
          onSuffixIconPressed: () {
            expandableController.toggle();
          },
        ),
      ),
      collapsed: Container(),
      expanded: ListView.separated(
        itemCount: subCategories.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(
          top: AppSpacing.spacing8,
          left: AppSpacing.spacing12,
        ),
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const Gap(AppSpacing.spacing8),
        itemBuilder: (context, index) {
          final subCategory = subCategories[index];
          return CategoryTile(
            category: subCategory,
            suffixIcon: HugeIcons.strokeRoundedCheckmarkCircle01,
            onSelectCategory: (selectedCategory) {
              CategoryModel newCategory = category.copyWith(
                subCategories: [selectedCategory],
              );

              Log.d(newCategory.toJson(), label: 'category');

              // if picking category, then return to previous screen with selected category
              if (!isManageCategory) {
                context.pop(newCategory);
              } else {
                showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  builder: (context) =>
                      CategoryFormScreen(categoryId: selectedCategory.id),
                );
              }
            },
          );
        },
      ),
      theme: const ExpandableThemeData(
        hasIcon: false,
        useInkWell: false,
        tapHeaderToExpand: false,
      ),
    );
  }
}
