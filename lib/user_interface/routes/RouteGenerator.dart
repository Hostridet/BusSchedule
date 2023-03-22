import 'package:flutter/material.dart';
import 'package:front/user_interface/pages/BusTypePage.dart';
import 'package:front/user_interface/pages/CityPage.dart';
import 'package:front/user_interface/pages/RoadPage.dart';

import '../pages/BusPage.dart';
import '../pages/SchedulePage.dart';


class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case '/schedule':
        return CustomPageRoute(
          builder: (context) => const SchedulePage(),
          settings: settings,
        );
      case '/bustype':
        return CustomPageRoute(
          builder: (context) => const BusTypePage(),
          settings: settings,
        );
      case '/city':
        return CustomPageRoute(
          builder: (context) => const CityPage(),
          settings: settings,
        );
      case '/bus':
        return CustomPageRoute(
          builder: (context) => const BusPage(),
          settings: settings,
        );
      case '/road':
        return CustomPageRoute(
          builder: (context) => const RoadPage(),
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