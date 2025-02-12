import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> pushNamed(String route) async {
    await navigatorKey.currentState?.pushNamed(route);
  }

  Future<void> pushNamedAndRemoveAll(String route) async {
    await navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(route, (route) => false);
  }

  Future<void> pop() async {
    navigatorKey.currentState?.pop();
  }

  String? getCurrentRoute() {
    return ModalRoute.of(navigatorKey.currentState!.context)?.settings.name!;
  }
}
