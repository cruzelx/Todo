import 'package:auto_route/auto_route.dart';
import 'package:bloc_provider_test/router/router.gr.dart';
import 'package:flutter/material.dart';

class SideNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.work),
          title: Text("Provider Tasks"),
          onTap: () {
            ExtendedNavigator.root.pop();
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.blur_circular),
          title: Text("Bloc Tasks"),
          onTap: () {
            ExtendedNavigator.root.pop();
            ExtendedNavigator.root.push(Routes.blocScreen);
          },
        )
      ],
    );
  }
}
