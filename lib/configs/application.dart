import 'package:flutter/foundation.dart';
import 'package:charging_station/models/model.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Application {
  static bool debug = kDebugMode;
  static String domain = 'https://demo.listarapp.com';
  static DeviceModel? device;
  static PackageInfo? packageInfo;
  static SettingModel setting = SettingModel.fromDefault();
  static bool storeReview = false;

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
