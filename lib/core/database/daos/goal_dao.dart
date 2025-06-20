import 'package:drift/drift.dart';
import 'package:moneynest/core/database/moneynest_database.dart';
import 'package:moneynest/core/database/tables/goal_table.dart';
import 'package:moneynest/core/utils/logger.dart';

part 'goal_dao.g.dart';

@DriftAccessor(tables: [Goals])
class GoalDao extends DatabaseAccessor<AppDatabase> with _$GoalDaoMixin {
  final AppDatabase db;
  
  // Table reference
  late final goals = db.goals;

  GoalDao(this.db) : super(db);

  // ─── CRUD for Goals ─────────────────────────────


  /// Inserts a new Goal, returns its auto-incremented ID
  Future<int> addGoal(GoalsCompanion entry) async {
    Log.d('📝  addGoal → ${entry.toString()}');
    final id = await into(goals).insert(entry);
    Log.d('✔️  Goal inserted with id=$id');
    return id;
  }

  /// Streams all goals; logs each emission
  Stream<List<Goal>> watchAllGoals() {
    Log.d('🔍  Subscribing to watchAllGoals()');
    return select(goals).watch().map((list) {
      Log.d('📋  watchAllGoals emitted ${list.length} rows');
      return list;
    });
  }

  /// Streams single goal;
  Stream<Goal> watchGoalByID(int id) {
    Log.d('🔍  Subscribing to watchGoalByID($id)');
    return (select(goals)..where((g) => g.id.equals(id))).watchSingle();
  }

  /// Fetches a single goal by its ID, or null if not found.
  Future<Goal?> getGoalById(int id) {
    Log.d('🔍  Fetching getGoalById(id=$id)');
    return (select(goals)..where((g) => g.id.equals(id))).getSingleOrNull();
  }

  /// Updates an existing goal (matching by .id)
  Future<bool> updateGoal(Goal goal) async {
    Log.d('✏️  updateGoal → ${goal.toString()}');
    final success = await update(goals).replace(goal);
    Log.d('✔️  updateGoal success=$success');
    return success;
  }

  /// Deletes a goal by its ID
  Future<int> deleteGoal(int id) async {
    Log.d('🗑️  deleteGoal → id=$id');
    final count = await (delete(goals)..where((g) => g.id.equals(id))).go();
    Log.d('✔️  deleteGoal deleted $count row(s)');
    return count;
  }
}
