import 'package:digium/logger.dart';
import 'package:digium/pages/auth/login_page.dart';
import 'package:digium/pages/auth/register_page.dart';
import 'package:digium/pages/main_page.dart';
import 'package:digium/pages/museum/museum_detail_page.dart';
import 'package:digium/pages/onboard_page.dart';
import 'package:digium/pages/splash.dart';
import 'package:digium/providers/auth_provider.dart';
import 'package:digium/providers/menu_provider.dart';
import 'package:digium/providers/museum_provider.dart';
import 'package:digium/injector/locator.dart';
import 'package:digium/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String _h = '[main]';
Future main() async {
  Logger().setLogLevel(LogLevel.debugFinest);
  await dotenv.load(fileName: ".env");
  logSuccess(_h, ".env loaded");
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  WidgetsFlutterBinding.ensureInitialized();
  // depedency injector
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navLocator = getIt.get<NavigationService>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MuseumProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: _navLocator.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Digium',
        routes: {
          '/': (context) => const Splash(),
          '/onboard': (context) => const OnboardPage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const MainPage(),
          '/museum': (context) => const MuseumDetailPage(),
        },
      ),
    );
  }
}
