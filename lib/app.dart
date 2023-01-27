import 'package:flutter/material.dart';
import 'package:login_app/ui/screens/home_page.dart';
import 'package:login_app/ui/screens/landing_page.dart';
import 'package:login_app/ui/screens/register_page.dart';
import 'package:login_app/ui/screens/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/register': (context) {
          return RegisterPage();
        },
        '/login': (context) {
          return LoginPage();
        },
      },
      home: LandingPage(),
    );
  }
}
