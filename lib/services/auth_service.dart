import 'dart:convert';
import 'package:digium/constants/endpoint.dart';
import 'package:digium/injector/locator.dart';
import 'package:digium/logger.dart';
import 'package:digium/networks/dio_client.dart';
import 'package:digium/models/user_model.dart';

const _h = "[AUTH SERVICE]";

class AuthService {
  final _networkLocator = getIt.get<DioClient>();

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    var body = jsonEncode({
      'email': email,
      'password': password,
    });
    final response = await _networkLocator.dio.post(
      loginEndpoint,
      data: body,
    );

    switch (response.statusCode) {
      case 200:
        var data = response.data['data'];
        UserModel user = UserModel.fromJson(data['user']);
        user.token.value = 'Bearer ' + data['token'];
        return user;
      case 400:
        var errors = response.data['data'];
        UserModel error = UserModel.validateFromJson(errors);
        return error;
      case 401:
        logError(_h, response.data);
        throw Exception("Email/password salah!");
      default:
        logError(_h, response.data);
        throw Exception("Internal Server Error");
    }
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    var body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });
    final response = await _networkLocator.dio.post(
      registerEndpoint,
      data: body,
    );

    switch (response.statusCode) {
      case 200:
        var data = response.data['data'];
        UserModel user = UserModel.fromJson(data);
        return user;
      case 400:
        var errors = response.data['data'];
        UserModel error = UserModel.validateFromJson(errors);
        return error;
      default:
        logError(_h, response.data);
        throw Exception("Internal Server Error");
    }
  }

  Future<UserModel> profile({
    required String token,
  }) async {
    final response = await _networkLocator.dio.get(
      profileEndpoint,
    );
    switch (response.statusCode) {
      case 200:
        var data = response.data['data'];
        UserModel user = UserModel.fromJson(data);
        user.token.value = token;
        return user;
      default:
        logError(_h, response.data);
        throw Exception("Internal Server Error");
    }
  }
}
