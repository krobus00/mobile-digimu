import 'dart:convert';
import 'package:digium/constants/endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:digium/models/museum_model.dart';

class MuseumService {
  Future<List<MuseumModel>> getMuseums({
    String? search,
    bool? top,
    int? random,
    int? startPrice,
    int? endPrice,
  }) async {
    var url = "$baseURL/$musuemListEndpoint";
    Map<String, String> queryParameters = {
      'search': search ?? "",
      'top': top.toString(),
    };

    print(Uri.parse(url).replace(queryParameters: queryParameters));
    var response = await http.get(
      Uri.parse(url).replace(queryParameters: queryParameters),
      headers: baseHeader,
    );
    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body)['data'];
        List<MuseumModel> museums = [];
        for (var museum in data) {
          museums.add(MuseumModel.fromJson(museum));
        }
        return museums;
      default:
        throw Exception("Internal Server Error");
    }
  }
}
