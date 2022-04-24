import 'package:digium/providers/auth_provider.dart';
import 'package:digium/providers/museum_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int? isViewed;
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    MuseumProvider museumProvider =
        Provider.of<MuseumProvider>(context, listen: false);
    String? token = prefs.getString("jwt");
    if (token != null && token.isNotEmpty) {
      bool validToken = await authProvider.getAuthInfo(token);
      if (validToken) {
        await museumProvider.getMuseums(null, true, null, null, null);
        return Navigator.pushReplacementNamed(context, '/home');
      }
    }
    await prefs.remove("jwt");
    await Future.delayed(const Duration(milliseconds: 2000), () {});

    prefs.setInt(
      "onboard",
      bool.fromEnvironment(dotenv.env['ALWAYS_SHOW_ONBOARD'] ?? "") ? 0 : 1,
    );

    isViewed = prefs.getInt("onboard");
    if (isViewed != 0) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.pushReplacementNamed(context, '/onboard');
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
