import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Paystack Demo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          checkOutCard(),
        ],
      ),
    );
  }

  Widget checkOutCard() {
    return InkWell(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.blueAccent,
        elevation: 15,
        child: Container(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  "Pay with Paystack",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.payment_rounded,
                  size: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
