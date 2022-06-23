import 'dart:convert';
import 'package:digium/constants/endpoint.dart';
import 'package:digium/injector/locator.dart';
import 'package:digium/utils/logger.dart';
import 'package:digium/services/dio_service.dart';
import 'package:digium/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';

const _h = "[AUTH SERVICE]";

class AuthService {
  final _networkLocator = getIt.get<DioClient>();
  final _googleSignIn = GoogleSignIn();

  Future<UserModel> sso() async {
    try {
      var res = await _googleSignIn.signIn();
      var googleKey = await res!.authentication;
      var body = jsonEncode({
        'email': res.email,
        'remember_token': googleKey.accessToken,
      });
      final response = await _networkLocator.dio.post(
        loginEndpoint,
        data: body,
      );
      var data = response.data['data'];

      UserModel user = UserModel.fromJson(data['user']);
      user.token.value = 'Bearer ' + data['token'];
      user.clearError();
      return user;
    } catch (e) {
      if (e.runtimeType == DioError) {
        var dioException = e as DioError;
        final result = dioException.response!;
        logError(_h, result.data.toString());

        throw Exception("Internal Server Error");
      }
      logError(_h, e.toString());
      throw Exception("Something wrong");
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      var body = jsonEncode({
        'email': email,
        'password': password,
      });
      final response = await _networkLocator.dio.post(
        loginEndpoint,
        data: body,
      );

      var data = response.data['data'];
      logDebug(_h, "masuk?");
      UserModel user = UserModel.fromJson(data['user']);
      user.token.value = 'Bearer ' + data['token'];
      user.clearError();

      return user;
    } catch (e) {
      if (e.runtimeType == DioError) {
        var dioException = e as DioError;
        final result = dioException.response!;
        logError(_h, result.data.toString());

        switch (result.statusCode) {
          case 400:
            var errors = result.data['data'];
            UserModel error = UserModel.validateFromJson(errors);
            return error;
          case 401:
            throw Exception("Email/password salah!");
          default:
            throw Exception("Internal Server Error");
        }
      }
      logError(_h, e.toString());
      throw Exception("Something wrong");
    }
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      var body = jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      });

      final response = await _networkLocator.dio.post(
        registerEndpoint,
        data: body,
      );

      var data = response.data['data'];
      UserModel user = UserModel.fromJson(data);
      user.clearError();
      return user;
    } catch (e) {
      if (e.runtimeType == DioError) {
        var dioException = e as DioError;
        final result = dioException.response!;
        logError(_h, result.data.toString());

        switch (result.statusCode) {
          case 400:
            var errors = result.data['data'];
            UserModel error = UserModel.validateFromJson(errors);
            return error;
          case 401:
            throw Exception("Email/password salah!");
          default:
            throw Exception("Internal Server Error");
        }
      }
      logError(_h, e.toString());
      throw Exception("Something wrong");
    }
  }

  Future<UserModel> profile({
    required String token,
  }) async {
    try {
      final response = await _networkLocator.dio.get(
        profileEndpoint,
      );

      var data = response.data['data'];
      UserModel user = UserModel.fromJson(data);
      user.token.value = token;
      return user;
    } catch (e) {
      if (e.runtimeType == DioError) {
        var dioException = e as DioError;
        final result = dioException.response!;
        logError(_h, result.data.toString());

        throw Exception("Internal Server Error");
      }
      logError(_h, e.toString());
      throw Exception("Something wrong");
    }
  }

  Future<void> logout() async {
    try {
      await _networkLocator.dio.get(
        logoutEndpoint,
      );
    } catch (e) {
      if (e.runtimeType == DioError) {
        var dioException = e as DioError;
        final result = dioException.response!;
        logError(_h, result.data.toString());
        throw Exception("Internal Server Error");
      }
      logError(_h, e.toString());
      throw Exception("Something wrong");
    }
  }
}
