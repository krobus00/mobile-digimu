import 'package:digium/constants/endpoint.dart';
import 'package:digium/utils/logger.dart';
import 'package:digium/injector/locator.dart';
import 'package:digium/services/navigation_service.dart';
import 'package:digium/utils/shared_preference_helper.dart';
import 'package:dio/dio.dart';

const _h = "[DIO]";

class Logging extends Interceptor {
  final _prefsLocator = getIt.get<SharedPreferenceHelper>();
  final _navLocator = getIt.get<NavigationService>();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logDebug(_h, "REQUEST[${options.method}] => PATH: ${options.path}");
    options.headers['Authorization'] = _prefsLocator.getUserToken();
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logDebug(
      _h,
      "RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}",
    );

    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    logDebug(
      _h,
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    if (err.response?.statusCode == 401) {
      await _prefsLocator.removeUserToken();
      if (err.requestOptions.path != loginEndpoint) {
        _navLocator.navigateAndReplaceTo(
          routeName: "/login",
        );
      }
    }

    return super.onError(err, handler);
  }
}

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseURL,
      headers: baseHeader,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  )..interceptors.add(Logging());
  Dio get dio => _dio;
}
