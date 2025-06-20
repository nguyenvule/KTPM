import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynest/core/components/form_fields/custom_select_field.dart';
import 'package:moneynest/core/router/routes.dart';
import 'package:moneynest/core/utils/logger.dart';
import 'package:moneynest/features/category/data/model/category_model.dart';

class TransactionCategorySelector extends HookConsumerWidget {
  final TextEditingController controller;
  final ValueChanged<CategoryModel?> onCategorySelected;
  final CategoryType? categoryTypeFilter;

  const TransactionCategorySelector({
    super.key,
    required this.controller,
    required this.onCategorySelected,
    this.categoryTypeFilter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* SizedBox(
            height: double.infinity,
            child: SecondaryButton(
              onPressed: () async {
                final category = await context.push<CategoryModel>(
                  Routes.categoryList,
                );
                Log.d(
                  category?.toJson(),
                  label: 'category selected via icon button',
                );
                if (category != null) {
                  onCategorySelected(category);
                }
              },
              icon: HugeIcons.strokeRoundedShoppingBag01,
            ),
          ),
          const Gap(AppSpacing.spacing8), */
          Expanded(
            child: CustomSelectField(
              controller: controller,
              label: 'Mục đích',
              hint: 'Chọn mục đích',
              isRequired: true,
              onTap: () async {
                final category = await context.push<CategoryModel>(
                  Routes.categoryList,
                  extra: categoryTypeFilter,
                );
                Log.d(
                  category?.toJson(),
                  label: 'category selected via text field',
                );
                if (category != null) {
                  onCategorySelected(category);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
