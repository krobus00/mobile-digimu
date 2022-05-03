import 'package:digium/networks/dio_client.dart';
import 'package:digium/services/navigation_service.dart';
import 'package:digium/sharedprefs/shared_preference_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  // define depedency injector
  final _prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferenceHelper>(
    SharedPreferenceHelper(prefs: _prefs),
  );
  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<DioClient>(DioClient());
}
