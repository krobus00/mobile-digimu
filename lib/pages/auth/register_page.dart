import 'package:digium/injector/locator.dart';
import 'package:digium/models/user_model.dart';
import 'package:digium/providers/auth_provider.dart';
import 'package:digium/services/navigation_service.dart';
import 'package:digium/constants/theme.dart';
import 'package:digium/utils/utils.dart';
import 'package:digium/widgets/custom_field.dart';
import 'package:digium/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController(text: "");
  final _emailController = TextEditingController(text: "");
  final _passwordController = TextEditingController(text: "");
  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;
    final _navLocator = getIt.get<NavigationService>();

    handleRegister() async {
      if (authProvider.validate) {
        setState(() {
          isLoading = true;
        });
        unfocus(context);
        if (await authProvider.register(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
        )) {
          _nameController.text = "";
          _emailController.text = "";
          _passwordController.text = "";
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              "Registrasi berhasil",
              textAlign: TextAlign.center,
            ),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: dangerColor,
              content: const Text(
                "Registrasi gagal!",
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        setState(() {
          isLoading = false;
        });
      }
    }

    handleSSO() async {
      setState(() {
        isLoading = true;
      });
      unfocus(context);
      if (await authProvider.sso()) {
        _navLocator.navigateAndReplaceTo(routeName: "/home");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: dangerColor,
            content: const Text(
              "Email/password salah!",
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return Container(
        height: 139,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/header/auth_header.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.all(authMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Register for an account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget nameInput() {
      return Container(
        margin: const EdgeInsets.only(top: 70),
        child: CustomField(
          label: "Full name",
          hintText: "Your full name",
          isLoading: isLoading,
          errorText: user?.name.error,
          controller: _nameController,
          prefixIcon: Icons.person,
          onChanged: authProvider.validateName,
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: CustomField(
          label: "Email",
          hintText: "Your email address",
          isLoading: isLoading,
          errorText: user?.email.error,
          controller: _emailController,
          prefixIcon: Icons.email,
          onChanged: authProvider.validateEmail,
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: CustomField(
          label: "Password",
          hintText: "********",
          isLoading: isLoading,
          errorText: user?.password.error,
          controller: _passwordController,
          prefixIcon: Icons.password,
          isPassword: true,
          onChanged: authProvider.validatePassword,
        ),
      );
    }

    Widget registerButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: isLoading
            ? const LoadingButton()
            : TextButton(
                onPressed: () async {
                  await handleRegister();
                },
                style: TextButton.styleFrom(
                  backgroundColor: warningColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontWeight: medium,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
      );
    }

    Widget googleButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        child: isLoading
            ? const LoadingButton()
            : TextButton(
                onPressed: () async {
                  await handleSSO();
                },
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Google",
                  style: TextStyle(
                    fontWeight: medium,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
      );
    }

    Widget footer() {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Already have an account?",
              style: TextStyle(fontSize: 14),
            ),
            TextButton(
              onPressed: () {
                user?.clearError();
                _navLocator.navigateAndReplaceTo(routeName: "/login");
              },
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: authMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nameInput(),
                emailInput(),
                passwordInput(),
                registerButton(),
                googleButton(),
              ],
            ),
          ),
          const Spacer(),
          footer(),
        ],
      ),
    );
  }
}
