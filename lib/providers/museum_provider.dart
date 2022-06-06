import 'package:digium/models/museum_model.dart';
import 'package:digium/services/museum_service.dart';
import 'package:flutter/material.dart';
import 'package:digium/models/museum_pagination_model.dart';

class MuseumProvider with ChangeNotifier {
  final _museumService = MuseumService();
  MuseumModel? _museum;
  List<MuseumModel> _museums = [];
  List<MuseumModel> _topMuseums = [];

  MuseumModel? get museum => _museum;
  List<MuseumModel> get museums => _museums;
  List<MuseumModel> get topMuseums => _topMuseums;

  bool _paginationHasNext = true;

  set museum(MuseumModel? museum) {
    _museum = museum;
    notifyListeners();
  }

  set topMuseums(List<MuseumModel> museums) {
    _topMuseums = museums;
    notifyListeners();
  }

  set museums(List<MuseumModel> museums) {
    _museums = museums;
    notifyListeners();
  }

  Future<bool> getMuseums({
    String? search,
    bool? top,
    bool? random,
    int? startPrice,
    int? endPrice,
    int? page,
    int? paginate,
  }) async {
    try {
      List<MuseumModel> museums = await _museumService.getMuseums(
        search: search,
        top: top,
        random: random,
        startPrice: startPrice,
        endPrice: endPrice,
        page: page,
        paginate: paginate,
      );
      if (top != null && top) {
        _topMuseums = museums;
      } else {
        _museums = museums;
      }

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getMuseum({
    String? search,
    required int pageSize,
    required int page,
    required bool firstFetch,
  }) async {
    try {
      if (!_paginationHasNext && !firstFetch) {
        return false;
      }
      MuseumPaginationModel pagination = await _museumService.getMuseum(
        search: search,
        page: page,
        pageSize: pageSize,
      );
      if (firstFetch) {
        _museums = pagination.items;
      } else {
        _museums.addAll(pagination.items);
      }
      _paginationHasNext = pagination.count >= pageSize * (page + 1);

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
