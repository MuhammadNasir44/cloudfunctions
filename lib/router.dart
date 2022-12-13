



import 'package:flutter/material.dart';

import 'home_detail_screen.dart';
import 'home_screen.dart';




class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {


    switch (settings.name) {


      case 'Home_Screen':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case 'Home_Detail_Screen':
        final args = settings.arguments as HomeDetailScreen;

        return MaterialPageRoute(builder: (_) => HomeDetailScreen(getTitle: args.getTitle,getDetail:args.getDetail,));

      default:
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                )
        );
    }
  }
}