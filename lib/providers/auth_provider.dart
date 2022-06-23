import 'package:digium/injector/locator.dart';
import 'package:digium/models/user_model.dart';
import 'package:digium/models/validation_model.dart';
import 'package:digium/services/auth_service.dart';
import 'package:digium/utils/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:digium/extensions/string_extensions.dart';

class AuthProvider with ChangeNotifier {
  final _prefsLocator = getIt.get<SharedPreferenceHelper>();
  final _authService = AuthService();

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

  Future<bool> sso() async {
    try {
      UserModel user = await _authService.sso();
      _user = user;
      if (validate) {
        await _prefsLocator.setUserToken(userToken: user.token.value!);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      UserModel user = await _authService.register(
          name: name, email: email, password: password);
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
          await _authService.login(email: email, password: password);

      _user = user;
      if (validate) {
        await _prefsLocator.setUserToken(userToken: user.token.value!);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getAuthInfo(String token) async {
    try {
      UserModel user = await _authService.profile(token: token);
      _user = user;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await _authService.logout();
      await _prefsLocator.removeUserToken();
      return true;
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
