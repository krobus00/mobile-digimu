import 'package:digium/injector/locator.dart';
import 'package:digium/providers/auth_provider.dart';
import 'package:digium/services/navigation_service.dart';
import 'package:digium/utils/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:digium/extensions/string_extensions.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    final _prefsLocator = getIt.get<SharedPreferenceHelper>();
    final _navLocator = getIt.get<NavigationService>();
    if (dotenv.env['ALWAYS_SHOW_ONBOARD'].parseBool()) {
      await _prefsLocator.removeUserToken();
      await _prefsLocator.setOnboardFlag(
        flag: false,
      );
    }
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    String? token = _prefsLocator.getUserToken();
    if (token != null && token.isNotEmpty) {
      bool validToken = await authProvider.getAuthInfo(token);
      if (validToken) {
        return _navLocator.navigateAndReplaceTo(routeName: '/home');
      }
    }
    await _prefsLocator.removeUserToken();
    await Future.delayed(const Duration(milliseconds: 2000), () {});

    bool isViewed = _prefsLocator.getOnboardFlag();
    if (isViewed) {
      return _navLocator.replaceTo(routeName: '/login');
    } else {
      return _navLocator.replaceTo(routeName: '/onboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/splash.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'digium',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Learn to love your country',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
