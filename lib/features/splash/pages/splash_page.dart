import 'package:base_structure/core/domain/navigation/inavigation_controller.dart';
import 'package:base_structure/core/shared_widgets/images/general_image.dart';

import 'package:base_structure/core/singletons/resource_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var navigationController = Get.find<INavigationController>();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      navigationController.navigateAsync(NavigatePage.HOME,
          transition: Transition.topLevel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GeneralImage(
            url: ResourcePath.splash_bg_icon,
            width: 1.sw,
            height: 1.sh,
          ),
          const Center(
            child: GeneralImage(
              url: ResourcePath.splash_logo_icon,
            ),
          ),
        ],
      ),
    );
  }
}
