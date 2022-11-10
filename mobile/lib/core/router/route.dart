import 'package:auto_route/auto_route.dart';
import 'package:libello/features/dashboard/presentation/pages/dashboard.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: DashboardPage, initial: true),
  ],
)
class $LibelloAppRouter {}
