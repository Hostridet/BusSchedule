import 'package:flutter/material.dart';
import 'package:front/user_interface/pages/BusTypePage.dart';


class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case '/bustype':
        return CustomPageRoute(
          builder: (context) => const BusTypePage(),
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