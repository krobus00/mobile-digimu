import 'package:digium/injector/locator.dart';
import 'package:digium/models/user_model.dart';
import 'package:digium/providers/auth_provider.dart';
import 'package:digium/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = Provider.of<AuthProvider>(context);
    final _navLocator = getIt.get<NavigationService>();
    UserModel? user = _authProvider.user;

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/header/transaction_header.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "${user?.name.value}",
          style: const TextStyle(fontSize: 32),
        ),
        Text(
          "${user?.email.value}",
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size.fromHeight(50), // NEW
            ),
            onPressed: () async {
              bool isSuccess = await _authProvider.logout();
              if (isSuccess) {
                _navLocator.navigateAndReplaceTo(
                  routeName: "/login",
                );
              }
            },
            child: const Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
