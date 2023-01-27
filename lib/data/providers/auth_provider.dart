import 'package:flutter/foundation.dart';
import 'package:login_app/data/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  String? username;
  String? password;
  bool isLoggedIn = false;

  final service = AuthService();

  // Future login(String username, String password) async {
  //   if (username != "Edozie") {
  //     throw Exception('Invalid username or password');
  //   } else {
  //     this.username = username;
  //     this.password = password;
  //     isLoggedIn = true;

  //     notifyListeners();
  //   }
  // }

  Future login(String username, String password) async {
    var res = await service.login(username: username, password: password);

    if (res['code'] == 200) {
      this.username = username;
      this.password = password;
      isLoggedIn = true;

      notifyListeners();
      return 'Logged in successfully';
    }

    if (res['code'] == 406) {
      throw Exception('Login unsuccessful. Please try again.');
    }

    return res;
  }

  Future signup(
    String username,
    String email,
    String password, {
    bool isLoggedIn = false,
  }) async {
    this.username = username;
    this.password = password;

    var res = await service.signup(
        email: email, password: password, username: username);
   
    if (res['code'] == 200) {
      // setState(() {
      //   isLoading= false;
      // });
      this.isLoggedIn = isLoggedIn;

      notifyListeners();
      return 'Registration successfully';
    }

    if (res['code'] == 422) {
      throw Exception(res['message']??'Registration unsuccessful!');
    }
throw Exception('Registration unsuccessful!');
  }

  logout() {
    username = null;
    password = null;
    isLoggedIn = false;

    notifyListeners();
  }
}

final authProvider = AuthProvider();
