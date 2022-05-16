import 'dart:convert';
import 'package:digium/constants/endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:digium/models/user_model.dart';

class AuthService {
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    var url = "$baseURL/$loginEndpoint";
    var body = jsonEncode({
      'email': email,
      'password': password,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: baseHeader,
      body: body,
    );
    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body)['data'];
        UserModel user = UserModel.fromJson(data['user']);
        user.token.value = 'Bearer ' + data['token'];
        return user;
      case 400:
        var errors = jsonDecode(response.body)['data'];
        UserModel error = UserModel.validateFromJson(errors);
        return error;
      case 401:
        throw Exception("Email/password salah!");
      default:
        throw Exception("Internal Server Error");
    }
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    var url = "$baseURL/$registerEndpoint";
    var body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: baseHeader,
      body: body,
    );
    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body)['data'];
        UserModel user = UserModel.fromJson(data);
        return user;
      case 400:
        var errors = jsonDecode(response.body)['data'];
        UserModel error = UserModel.validateFromJson(errors);
        return error;
      default:
        throw Exception("Internal Server Error");
    }
  }

  Future<UserModel> profile({
    required String token,
  }) async {
    var url = "$baseURL/$profileEndpoint";

    var authHeader = baseHeader;
    authHeader['Authorization'] = token;
    var response = await http.get(
      Uri.parse(url),
      headers: authHeader,
    );
    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body)['data'];
        UserModel user = UserModel.fromJson(data);
        user.token.value = token;
        return user;
      case 401:
        throw Exception("Invalid Token");
      default:
        throw Exception("Internal Server Error");
    }
  }
}
