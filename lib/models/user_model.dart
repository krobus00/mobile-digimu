import 'package:digium/models/validation_model.dart';
import 'package:digium/utils.dart';

class UserModel {
  late int id;
  late ValidationStringModel name = ValidationStringModel(null, null);
  late ValidationStringModel email = ValidationStringModel(null, null);
  late ValidationStringModel token = ValidationStringModel(null, null);
  late ValidationStringModel password = ValidationStringModel(null, null);

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name.value = json['name'];
    email.value = json['email'];
  }

  UserModel.validateFromJson(List<dynamic> json) {
    name.error = getErrorMessage("name", json);
    email.error = getErrorMessage("email", json);
    password.error = getErrorMessage("password", json);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name.value,
      'email': email.value,
    };
  }

  clearError() {
    name.clearError();
    email.clearError();
    password.clearError();
  }
}
