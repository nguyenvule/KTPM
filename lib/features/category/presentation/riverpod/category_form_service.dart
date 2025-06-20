import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moneynest/core/constants/app_text_styles.dart';
import 'package:moneynest/core/database/database_provider.dart';
import 'package:moneynest/core/database/moneynest_database.dart';
import 'package:moneynest/features/category/data/model/category_model.dart';
import 'package:moneynest/features/category/presentation/riverpod/category_actions_provider.dart';
import 'package:moneynest/features/category/presentation/riverpod/category_providers.dart';
import 'package:toastification/toastification.dart';

class CategoryFormService {
  Future<void> save(
    BuildContext context,
    WidgetRef ref,
    CategoryModel categoryModel,
  ) async {
    // Đảm bảo categoryType được truyền vào DB
    // (Nếu cần ánh xạ sang int hoặc String thì xử lý tại đây)
    // Basic validation
    if (categoryModel.title.isEmpty || categoryModel.parentId == null) {
      // Show an error message (e.g., using a SnackBar)
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text(
          'Title and parent category cannot be empty.',
          style: AppTextStyles.body2,
        ),
        applyBlurEffect: true,
        style: ToastificationStyle.flatColored,
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 3),
      );
      return;
    }

    final db = ref.read(databaseProvider);

    // Create a CategoriesCompanion from form data
    final categoryCompanion = CategoriesCompanion(
      id: categoryModel.id == null
          ? const Value.absent()
          : Value(categoryModel.id!),
      title: Value(categoryModel.title),
      iconName: Value(categoryModel.iconName),
      parentId: Value(categoryModel.parentId), // Use selected parent ID
      description: Value(categoryModel.description ?? ''),
      categoryType: Value(categoryModel.categoryType.index), // Lưu dưới dạng int
    );

    try {
      // TODO: Nếu categoryType cần ánh xạ sang int hoặc String cho DB thì xử lý tại đây
      await db.categoryDao.upsertCategory(
        categoryCompanion,
      ); // Use upsert for create/update
      // Clear the selected parent state after saving
      ref.read(selectedParentCategoryProvider.notifier).state = null;
      if (!context.mounted) return;
      context.pop(); // Go back after successful save
    } catch (e) {
      // Handle database save errors
      if (!context.mounted) return;
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text('Failed to save category: $e'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }

  void delete(
    BuildContext context,
    WidgetRef ref, {
    required CategoryModel categoryModel,
  }) {
    final actions = ref.read(categoriesActionsProvider);
    actions.delete(categoryModel.id ?? 0);
  }
}
