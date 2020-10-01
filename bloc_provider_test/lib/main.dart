import 'package:auto_route/auto_route.dart';
import 'package:bloc_provider_test/locator/locator.dart';
import 'package:bloc_provider_test/router/router.gr.dart';
import 'package:bloc_provider_test/screens/mainScreen/mainScreen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

void main() {
  setupLocator();
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: ExtendedNavigator.builder<Router>(
          router: Router(),
          navigatorKey: navKey,
          builder: BotToastInit(),
          observers: [BotToastNavigatorObserver()]),
      debugShowCheckedModeBanner: false,
    );
  }
}
