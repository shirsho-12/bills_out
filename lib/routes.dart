import 'package:flutter/material.dart';

import 'views/home/home_view.dart';

class RouteGenerator {
  static const String homePage = '/home';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomeView());

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('404 Route Not Found'),
                  ),
                ));
    }
  }
}
