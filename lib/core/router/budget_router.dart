import 'package:go_router/go_router.dart';
import 'package:moneynest/core/router/routes.dart';
import 'package:moneynest/features/budget/presentation/screens/budget_details_screen.dart';
import 'package:moneynest/features/budget/presentation/screens/budget_form_screen.dart';

class BudgetRouter {
  static final routes = <GoRoute>[
    GoRoute(
      path: Routes.budgetDetails,
      builder: (context, state) => const BudgetDetailsScreen(),
    ),
    GoRoute(
      path: Routes.budgetForm,
      builder: (context, state) => const BudgetFormScreen(),
    ),
  ];
}
