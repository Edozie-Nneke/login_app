import 'package:flutter/material.dart';
import 'package:login_app/data/providers/auth_provider.dart';
import 'package:login_app/ui/screens/home_page.dart';
import 'package:login_app/ui/screens/login_page.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() {
    return _LandingPageState();
  }
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    authProvider.addListener(onChangeNotify);

    super.initState();
  }

  @override
  void dispose() {
    authProvider.removeListener(onChangeNotify);

    super.dispose();
  }

  onChangeNotify() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return !authProvider.isLoggedIn
        ? LoginPage()
        : HomePage(title: "Welcome, ${authProvider.username}!");
  }
}
