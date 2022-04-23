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
        user.token = 'Bearer ' + data['token'];
        return user;
      case 400:
        throw Exception("Error validation");
      default:
        throw Exception("Internal Server Error");
    }
  }

  Future<bool> register({
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
        return true;
      case 400:
        throw Exception(jsonDecode(response.body)['data']);
      default:
        throw Exception("Internal Server Error");
    }
  }
}
