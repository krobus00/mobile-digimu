import 'package:digium/models/user_model.dart';
import 'package:digium/services/auth_service.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;
  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      bool success = await AuthService()
          .register(name: name, email: email, password: password);
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      UserModel user =
          await AuthService().login(email: email, password: password);
      _user = user;
      return true;
    } catch (e) {
      return false;
    }
  }
}
