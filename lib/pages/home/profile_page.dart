import 'package:digium/models/user_model.dart';
import 'package:digium/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;

    return Scaffold(
      body: Center(
        child: Text("Hi ${user?.name.value}"),
      ),
    );
  }
}
