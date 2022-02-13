import 'package:bloc_counter/presentation/screens/home_screen.dart';
import 'package:bloc_counter/presentation/screens/second_screen.dart';
import 'package:bloc_counter/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(
            title: 'Home',
            color: Colors.greenAccent,
          ),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (context) => const SecondScreen(
            title: 'Second',
            color: Colors.redAccent,
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (context) => const ThirdScreen(
            title: 'Third',
            color: Colors.blueAccent,
          ),
        );

      default:
        return null;
    }
  }
}
