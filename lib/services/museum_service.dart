import 'package:digium/constants/endpoint.dart';
import 'package:digium/injector/locator.dart';
import 'package:digium/networks/dio_client.dart';
import 'package:digium/models/museum_model.dart';
import 'package:digium/logger.dart';

const _h = "[MUSEUM SERVICE]";

class MuseumService {
  final _networkLocator = getIt.get<DioClient>();

  Future<List<MuseumModel>> getMuseums({
    String? search,
    bool? top,
    bool? random,
    int? startPrice,
    int? endPrice,
    int? page = 1,
    int? paginate = 10,
    String? orderBy,
  }) async {
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

    switch (response.statusCode) {
      case 200:
        var res = response.data['data'];
        List<MuseumModel> museums = [];
        for (var museum in res['data']) {
          museums.add(MuseumModel.fromJson(museum));
        }
        return museums;
      default:
        logError(_h, response.data);
        throw Exception("Internal Server Error");
    }
  }
}
