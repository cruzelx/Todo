import 'package:auto_route/auto_route_annotations.dart';
import 'package:bloc_provider_test/screens/blocScreen/blocScreen.dart';
import 'package:bloc_provider_test/screens/mainScreen/mainScreen.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AdaptiveRoute(
    page: MainScreen,
    initial: true,
  ),
  AdaptiveRoute(page: BlocScreen)
])
class $Router {}
