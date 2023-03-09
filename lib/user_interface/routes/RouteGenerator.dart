

import 'package:flutter/material.dart';
import 'package:front/user_interface/pages/DirectionPage.dart';
import 'package:front/user_interface/pages/SubjectPage.dart';

import '../pages/StudentPage.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case '/students':
        return CustomPageRoute(
          builder: (context) => const StudentPage(),
          settings: settings,
        );
      case '/subject':
        return CustomPageRoute(
          builder: (context) => const SubjectPage(),
          settings: settings,
        );
      case '/direction':
        return CustomPageRoute(
          builder: (context) => const DirectionPage(),
          settings: settings,
        );
      default:
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR IN NAVIGATION'),
        ),
      );
    });
  }
}

class CustomPageRoute extends MaterialPageRoute {
  var settings;
  CustomPageRoute({builder, required this.settings}) : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}