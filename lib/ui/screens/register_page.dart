import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_app/data/providers/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final backgroundColor = const Color(0xFFF5F5F5);

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    usernameTextController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    if (value == null) return 'Not a valid email';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? 'Not a valid email' : null;
  }

  Future _signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      var result = await authProvider.signup(emailTextController.text,
          usernameTextController.text, passwordTextController.text);

      Navigator.pop(context);

      Fluttertoast.showToast(msg: result, backgroundColor: Colors.green);
    } on Exception catch (error) {
      String message = (error as dynamic).message;

      Navigator.pop(context);

      Fluttertoast.showToast(
          msg: message,
          backgroundColor: Colors.redAccent,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
    }
    Navigator.pop(context);
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
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.android, size: 87),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'HELLO, THERE',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Register below with your details!",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      _createTextField(
                        controller: emailTextController,
                        hintText: 'Email',
                        validator: _validateEmail,
                      ),
                      _createTextField(
                        controller: usernameTextController,
                        hintText: 'Username',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Provide a username";
                          }
                        },
                      ),
                      _createTextField(
                        controller: passwordTextController,
                        hintText: 'Password',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password can't be empty";
                          }
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: const Text('Register', style: TextStyle(fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Have an account? ',
                          style: TextStyle(fontSize: 16)),
                      InkWell(
                        onTap: () {
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createTextField({
    required String hintText,
    TextEditingController? controller,
    bool obscureText = false,
    String? Function(String? value)? validator,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: TextFormField(
        obscureText: obscureText,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
