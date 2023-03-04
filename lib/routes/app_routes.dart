
import 'package:acuacar_app/screens/execution_screen.dart';
import 'package:flutter/material.dart';

import 'package:acuacar_app/screens/screens.dart';

class AppRoutes {

  static String initialRoute = 'login';

  static Map<String, Widget Function(BuildContext)> getRoutes(){

    Map<String, Widget Function(BuildContext)> routes = {
      'login': (context) => const LoginScreen(),
      'register': (context) => const RegisterScreen(),
      'main': (context) => const MainScreen(),
      'task': (context) => const TaskScreen(),
      'excution': (context) => const ExecutionScreen()
      
    };

    return routes;

  }

}