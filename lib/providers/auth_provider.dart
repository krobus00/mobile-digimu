import 'package:digium/models/user_model.dart';
import 'package:digium/models/validation_model.dart';
import 'package:digium/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:digium/extensions/string_extensions.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  // getter
  int? get id => user?.id;
  String? get name => user?.name.value;
  String? get email => user?.email.value;
  String? get token => user?.token.value;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      UserModel user = await AuthService()
          .register(name: name, email: email, password: password);
      _user = user;
      if (validate) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      UserModel user =
          await AuthService().login(email: email, password: password);
      _user = user;
      if (validate) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  bool get validate {
    return _user?.email.error == null &&
        _user?.name.error == null &&
        _user?.password.error == null &&
        _user?.token.error == null;
  }

  void validateName(String? val) {
    if (val != null) {
      user?.name = ValidationStringModel(null, val);
    } else {
      user?.name = ValidationStringModel("Masukan nama dengan benar", val);
    }
    notifyListeners();
  }

  void validateEmail(String? val) {
    if (val != null && val.isValidEmail) {
      user?.email = ValidationStringModel(null, val);
    } else {
      user?.email = ValidationStringModel("Masukan alamat email", val);
    }
    notifyListeners();
  }

  void validatePassword(String? val) {
    if (val != null && val.isNotEmpty) {
      user?.password = ValidationStringModel(null, val);
    } else {
      user?.password =
          ValidationStringModel("Kata sandi tidak boleh kosong", val);
    }
    notifyListeners();
  }
}
