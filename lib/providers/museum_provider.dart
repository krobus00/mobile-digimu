import 'package:digium/models/museum_model.dart';
import 'package:digium/services/museum_service.dart';
import 'package:flutter/cupertino.dart';

class MuseumProvider with ChangeNotifier {
  MuseumModel? _museum;
  List<MuseumModel>? _museums;
  List<MuseumModel> _topMuseums = [];

  MuseumModel? get museum => _museum;
  List<MuseumModel>? get museums => _museums;
  List<MuseumModel> get topMuseums => _topMuseums;

  set museum(MuseumModel? museum) {
    _museum = museum;
    notifyListeners();
  }

  set topMuseums(List<MuseumModel> museums) {
    _topMuseums = museums;
    notifyListeners();
  }

  set museums(List<MuseumModel>? museums) {
    _museums = museums;
    notifyListeners();
  }

  Future<bool> getMuseums(
    String? search,
    bool? top,
    int? random,
    int? startPrice,
    int? endPrice,
  ) async {
    try {
      List<MuseumModel> museums = await MuseumService().getMuseums(
        search: search,
        top: top,
        random: random,
        startPrice: startPrice,
        endPrice: endPrice,
      );
      print(museums.length);
      if (top != null) {
        _topMuseums = museums;
      } else {
        _museums = museums;
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
