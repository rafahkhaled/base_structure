// ignore_for_file: do_not_use_environment, avoid_print, depend_on_referenced_packages

import 'package:base_structure/features/splash/pages/splash_page.dart';

import 'package:base_structure/core/domain/bindings/main_binding.dart';
import 'package:base_structure/core/singletons/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _setDeviceOrientation();

  runApp(const MyApp());
}

void _setDeviceOrientation() {
  // prevent device orientation just to portrait
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ScreenUtilInit(
            designSize: const Size(360, 800),
            minTextAdapt: true,
            rebuildFactor: RebuildFactors.change,
            ensureScreenSize: true,
            builder: (context, child) {
              return GetMaterialApp(
                  defaultTransition: Transition.noTransition,
                  debugShowCheckedModeBanner: false,
                  initialBinding: MainBinding(Get),
                  theme: ThemeData(
                    useMaterial3: false,
                    fontFamily: "Poppins",
                  ),
                  title: "Base structure",
                  home: const SplashPage());
            }));
    //   }),
  }
}
