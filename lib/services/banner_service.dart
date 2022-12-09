import 'package:digium/injector/locator.dart';
import 'package:digium/models/banner_models.dart';
import 'package:digium/services/dio_service.dart';
import 'package:digium/utils/logger.dart';
import 'package:dio/dio.dart';

const _h = "[BANNER SERVICE]";

class BannerService {
  final _networkLocator = getIt.get<DioClient>();

  Future<List<BannerModel>> getBanners() async {
    try {
      final response = await _networkLocator.dio.get(
        "banner",
      );
      print("banner response:\n${response.data['data']}");
      List<BannerModel> banners;
      // banners = List<BannerModel>.from(response.data['data'].map(
      //   (x) => BannerModel.fromJson(x),
      // ));
      banners = response.data['data']
          .map<BannerModel>((x) => BannerModel.fromJson(x))
          .toList();

      return banners;
    } catch (e) {
      if (e.runtimeType == DioError) {
        var dioException = e as DioError;
        final result = dioException.response!;
        logError(_h, result.data.toString());

        throw Exception("Internal Server Error");
      }
      logError(_h, e.toString());
      throw Exception("Something wrong");
    }
  }
}
