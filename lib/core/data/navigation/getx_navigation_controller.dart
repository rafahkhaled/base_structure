import 'package:base_structure/core/domain/bindings/main_binding.dart';
import 'package:base_structure/core/domain/navigation/inavigation_controller.dart';
import 'package:base_structure/core/utils.dart';
import 'package:base_structure/features/splash/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/medicine_search/presentation/view/pages/medicine_search_page.dart';

/// Navigation controller using GetX package
class GetXNavigationController extends INavigationController {
  GetXNavigationController();

  @override
  Future<void> navigateAsync(NavigatePage page,
      {NavigateMode mode = NavigateMode.PUSH,
      Map<String, dynamic>? params,
      Transition? transition,
      Duration? duration}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    // Assign page to navigate to based on the passed enum
    Widget? pageToNavigate = _getPageToNavigate(page, params);

    // Handle if no page is found
    if (pageToNavigate == null) {
      throw Exception("Invalid page: ${page.name}");
    }

    // Perform navigation based on the mode
    switch (mode) {
      case NavigateMode.PUSH:
        await Get.to(() => pageToNavigate,
            binding: MainBinding(Get),
            routeName: page.name,
            transition: transition ?? Transition.rightToLeft,
            duration: duration);
        break;
      case NavigateMode.PUSH_AND_OFF_ALL:
        await Get.offAll(() => pageToNavigate,
            binding: MainBinding(Get),
            routeName: page.name,
            transition: transition,
            duration: duration);
        break;
      case NavigateMode.PUSH_AND_REMOVE_UNTIL:
        await Get.offUntil(
          GetPageRoute(
            page: () => pageToNavigate,
            routeName: page.name,
            transition: transition,
          ),
          (route) => route.settings.name == "/${NavigatePage.HOME.name}",
        );
        break;
    }
  }

  /// Helper method to return a Widget based on the enum [NavigatePage]
  Widget? _getPageToNavigate(NavigatePage page, Map<String, dynamic>? params) {
    switch (page) {
      case NavigatePage.SPLASH:
        return const SplashPage();
      case NavigatePage.HOME:
        return const MedicineSearchPage();
      case NavigatePage.EMPTY:
      default:
        return null;
    }
  }

  @override
  void navigateBack({int countBack = 1}) {
    FocusManager.instance.primaryFocus?.unfocus();
    assert(countBack > 0, 'The count must be greater than zero');
    for (var i = 0; i < countBack; i++) {
      Get.back();
    }
  }

  @override
  void navigateBackUntil(NavigatePage page) {
    while (getCurrentPage() != page) {
      Get.back();
    }
  }

  @override
  NavigatePage getCurrentPage() {
    String currentRoute = Get.routing.current;

    if (currentRoute.startsWith("/")) {
      currentRoute = currentRoute.substring(1);
    }

    return NavigatePage.values.firstWhereOrNull((e) =>
            Utils.compareString(e.name, currentRoute, ignoreCase: true)) ??
        NavigatePage.EMPTY;
  }
}
