// ignore_for_file: unused_field

import 'package:base_structure/core/data/cache/flutter_secure_storage_cache_manager.dart';
import 'package:base_structure/core/data/navigation/getx_navigation_controller.dart';
import 'package:base_structure/core/data/network/network_service.dart';
import 'package:base_structure/core/domain/cache/icache_manager.dart';
import 'package:base_structure/core/domain/navigation/inavigation_controller.dart';
import 'package:base_structure/core/network/i_network_service.dart';

import 'package:base_structure/features/medicine_search/domain/medicine_search_repo.dart';
import 'package:base_structure/features/medicine_search/domain/i_medicine_search_repo.dart';
import 'package:base_structure/features/medicine_search/presentation/controller/medicine_search_controller.dart';

import 'package:get/get.dart';

class MainBinding implements Bindings {
  final GetInterface _getInterface;
  MainBinding(this._getInterface);
  @override
  void dependencies() {
    _getInterface.lazyPut(() {
      ICacheManager n = FlutterSecureStorageCacheManager();
      return n;
    });
    _getInterface.lazyPut(() {
      INetworkService n = NetworkService("https://api.fda.gov/drug/ndc.json");
      return n;
    });
    _getInterface.lazyPut(() {
      IMedicineSearchRepo n = MedicineSearchRepo(networkService: Get.find());
      return n;
    });

    _getInterface.lazyPut(() {
      INavigationController n = GetXNavigationController();
      return n;
    });

    _getInterface.put(
      MedicineSearchController(
        medicineSearchRepo: Get.find(),
      ),
    );
  }
}
