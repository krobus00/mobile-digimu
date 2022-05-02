import 'dart:convert';
import 'package:digium/constants/endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:digium/models/museum_model.dart';

class MuseumService {
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
    var url = "$baseURL/$musuemListEndpoint";
    Map<String, Object> params = {
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

    final queryParameters =
        params.map((key, value) => MapEntry(key, value.toString()));

    var response = await http.get(
      Uri.parse(url).replace(queryParameters: queryParameters),
      headers: baseHeader,
    );
    switch (response.statusCode) {
      case 200:
        var res = jsonDecode(response.body)['data'];
        List<MuseumModel> museums = [];
        for (var museum in res['data']) {
          museums.add(MuseumModel.fromJson(museum));
        }
        return museums;
      default:
        throw Exception("Internal Server Error");
    }
  }
}
