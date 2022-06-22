import 'package:digium/models/museum_model.dart';
import 'package:digium/services/museum_service.dart';
import 'package:flutter/material.dart';
import 'package:digium/models/museum_pagination_model.dart';

class MuseumProvider with ChangeNotifier {
  final _museumService = MuseumService();
  MuseumModel? _museum;
  List<MuseumModel> _museums = [];
  List<MuseumModel> _topMuseums = [];
  String _search = "";

  String get search => _search;
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

  set search(String keyword) {
    _search = keyword;
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
    required bool firstFetch,
  }) async {
    try {
      if (firstFetch) {
        _paginationHasNext = true;
      }
      if (!_paginationHasNext && !firstFetch) {
        return false;
      }
      MuseumPaginationModel pagination = await _museumService.getMuseums(
        search: search,
        top: top,
        random: random,
        startPrice: startPrice,
        endPrice: endPrice,
        page: page,
        paginate: paginate,
      );

      if (top != null && top) {
        _topMuseums = pagination.data;
        notifyListeners();
        return true;
      }
      if (firstFetch) {
        _museums = pagination.data;
      } else {
        _museums.addAll(pagination.data);
      }
      _paginationHasNext = pagination.paging.lastPage >= (page ?? 1);

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
