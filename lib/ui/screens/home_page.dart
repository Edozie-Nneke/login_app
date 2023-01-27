import 'package:flutter/material.dart';
import 'package:login_app/data/providers/auth_provider.dart';
import 'package:login_app/ui/widgets/swipe_detector.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _walletbalance = 0;

  @override
  Widget build(BuildContext context) {
    DragStartDetails dragdetails;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: log_out,
              icon: const Icon(
                Icons.login,
                size: 20.0,
              ))
        ],
      ),
      body: SwipeDetector(
          onSwipeUp: () {
            setState(() {
              _walletbalance++;
            });
          },
          onSwipeDown: () {
            setState(() {
              _walletbalance--;
            });
          },
          child: Center(
            heightFactor: MediaQuery.of(context).size.height,
            widthFactor: MediaQuery.of(context).size.width,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Faaaji wallet balance is:',
                  ),
                  Text(
                    '$_walletbalance',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  log_out() {
    authProvider.logout();
  }
}
