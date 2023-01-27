import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_app/data/providers/auth_provider.dart';
// import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final backgroundColor = const Color(0xFFF5F5F5);

  final formKey = GlobalKey<FormState>();

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  Future _signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    if (!formKey.currentState!.validate()) {
      Navigator.pop(context);

      return 'Login unsuccessful';
    }

    try {
      var res = await authProvider.login(
          usernameTextController.text, passwordTextController.text);

      Fluttertoast.showToast(msg: res, backgroundColor: Colors.green);
    } on Exception catch (e) {
      final msg = (e as dynamic).message;

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      Navigator.pop(context);

      Fluttertoast.showToast(
          msg: msg,
          backgroundColor: Colors.redAccent,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.android,
                  size: 100,
                ),
                Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'HELLO AGAIN',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                )),
                const Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Welcome back, you\'ve been missed!',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                )),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _creatTextField(
                          controller: usernameTextController,
                          hintText: 'Username',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username can not be empty';
                            }
                          }),
                      _creatTextField(
                          controller: passwordTextController,
                          hintText: 'Password',
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password can not be empty';
                            }
                          })
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _signIn,
                  child: Text('Log in', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member? ',
                        style: TextStyle(fontSize: 16),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/register');
                          },
                          child: const Text(
                            'Register now',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _creatTextField({
    required String hintText,
    TextEditingController? controller,
    bool obscureText = false,
    String? Function(String? value)? validator,
  }) {
    return Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextFormField(
          obscureText: obscureText,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)),
              hintText: hintText),
        ));
  }
}
