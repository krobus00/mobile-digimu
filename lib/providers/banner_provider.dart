import 'package:digium/models/banner_models.dart';
import 'package:digium/services/banner_service.dart';
import 'package:flutter/material.dart';

class BannerProvider with ChangeNotifier {
  final _bannerService = BannerService();
  List<BannerModel> _banners = [];
  List<BannerModel> get banners => _banners;

  set banners(List<BannerModel> banners) {
    _banners = banners;
    notifyListeners();
  }

  Future<bool> getBanners() async {
    try {
      List<BannerModel> banners = await _bannerService.getBanners();
      _banners = banners;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
