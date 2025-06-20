import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynest/core/database/moneynest_database.dart';
import 'package:moneynest/core/database/database_provider.dart';

/// A simple grouping of your DB write methods
class CategoriesActions {
  final Future<Category> Function(CategoriesCompanion) add;
  final Future<bool> Function(Category) update;
  final Future<int> Function(int) delete;

  CategoriesActions({
    required this.add,
    required this.update,
    required this.delete,
  });
}

/// Expose your CRUD methods via Riverpod
final categoriesActionsProvider = Provider<CategoriesActions>((ref) {
  final db = ref.watch(databaseProvider);
  return CategoriesActions(
    add: db.categoryDao.addCategory,
    update: db.categoryDao.updateCategory,
    delete: db.categoryDao.deleteCategoryById,
  );
});
