// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';

import '../screens/blocScreen/blocScreen.dart';
import '../screens/mainScreen/mainScreen.dart';

class Routes {
  static const String mainScreen = '/';
  static const String blocScreen = '/bloc-screen';
  static const all = <String>{
    mainScreen,
    blocScreen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.mainScreen, page: MainScreen),
    RouteDef(Routes.blocScreen, page: BlocScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    MainScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => MainScreen(),
        settings: data,
      );
    },
    BlocScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => BlocScreen(),
        settings: data,
      );
    },
  };
}
