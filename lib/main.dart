import 'package:acuacar_app/providers/login_form_provider.dart';
import 'package:acuacar_app/providers/register_form_provider.dart';
import 'package:acuacar_app/providers/user_provider.dart';
import 'package:acuacar_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisteFromProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getRoutes(),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
      )
    );
  }
}