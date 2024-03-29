import 'package:digium/pages/transaction/create_transaction_tab.dart';
import 'package:digium/pages/transaction/item_page.dart';
import 'package:digium/pages/transaction/payment_page.dart';
import 'package:digium/pages/transaction/ticket_page.dart';
import 'package:digium/providers/banner_provider.dart';
import 'package:digium/providers/transaction_provider.dart';
import 'package:digium/utils/logger.dart';
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
import 'package:intl/date_symbol_data_local.dart';

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
  await initializeDateFormatting("id_ID");
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
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BannerProvider(),
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
          '/transaction/tickets': (context) => const TransactionTicketPage(),
          '/transaction/payment': (context) => const TransactionPaymentPage(),
          '/transaction/items': (context) => const TransactionItemPage(),
          '/transaction/museum': (context) => const CreateTransactionTab()
        },
      ),
    );
  }
}
