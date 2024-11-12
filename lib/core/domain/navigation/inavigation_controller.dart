// ignore_for_file: constant_identifier_names

import 'package:get/get_navigation/src/routes/transitions_type.dart';

///High API to navigate between application pages
abstract class INavigationController {
  ///Navigates the user to [page]
  Future<void> navigateAsync(NavigatePage page,
      {NavigateMode mode = NavigateMode.PUSH,
      Map<String, dynamic>? params,
      Transition? transition = Transition.cupertino,
      Duration duration});

  ///Navigates back one step from the in navigator
  void navigateBack({int countBack = 1});

  ///Pops pages until a named page is the current page
  void navigateBackUntil(NavigatePage page);
  NavigatePage getCurrentPage();
}

enum NavigatePage {
  SPLASH,
  HOME,
  EMPTY,
}

enum NavigateMode { PUSH, PUSH_AND_OFF_ALL, PUSH_AND_REMOVE_UNTIL }
