import 'package:digium/constants/endpoint.dart';
import 'package:digium/injector/locator.dart';
import 'package:digium/models/museum_model.dart';
import 'package:digium/services/dio_service.dart';
import 'package:digium/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:digium/models/museum_pagination_model.dart';

const _h = "[MUSEUM SERVICE]";

class MuseumService {
  final _networkLocator = getIt.get<DioClient>();

  Future<MuseumPaginationModel> getMuseums({
    String? search,
    bool? top,
    bool? random,
    int? startPrice,
    int? endPrice,
    int? page = 1,
    int? paginate = 10,
    String? orderBy,
  }) async {
    try {
      Map<String, dynamic> params = {
        'page': page ?? 1,
        'paginate': paginate ?? 10,
      };
      if (search != null) {
        params['search'] = search;
      }
      if (top != null) {
        params['top'] = "";
      }
      if (random != null) {
        params['random'] = paginate ?? 10;
      }
      if (startPrice != null) {
        params['start_price'] = startPrice;
      }
      if (endPrice != null) {
        params['endPrice'] = endPrice;
      }

      final response = await _networkLocator.dio.get(
        musuemListEndpoint,
        queryParameters: params,
      );
      var res = response.data['data'];
      MuseumPaginationModel museums = MuseumPaginationModel.fromJson(res);

      return museums;
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

  Future<MuseumModel> getMuseum({
    required int museumId,
  }) async {
    try {
      final response = await _networkLocator.dio.get(
        "$musuemListEndpoint/$museumId",
      );

      MuseumModel museum = MuseumModel.fromJson(response.data['data']);
      return museum;
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
