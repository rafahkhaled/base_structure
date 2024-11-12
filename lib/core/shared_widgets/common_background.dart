import 'package:base_structure/core/domain/navigation/inavigation_controller.dart';
import 'package:base_structure/core/shared_widgets/inkwell/transparent_inkwell.dart';
import 'package:base_structure/core/shared_widgets/texts/base_text.dart';
import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:base_structure/core/singletons/font_sizes.dart';
import 'package:base_structure/core/singletons/font_weights.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommonBackground extends StatelessWidget {
  final double? height;
  final Widget child;
  final bool showBackButton;
  final String? title;
  const CommonBackground(
      {super.key,
      required this.child,
      this.height,
      this.showBackButton = true,
      this.title});

  @override
  Widget build(BuildContext context) {
    var navigationController = Get.find<INavigationController>();
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          Container(
            width: 1.sw,
            height: 196.h,
            padding: EdgeInsets.only(
              bottom: 40.h,
              left: 16.w,
              right: 16.w,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: showBackButton,
                  child: TransparentInkWell(
                    onTap: () {
                      navigationController.navigateBack();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.white,
                    ),
                  ),
                ),

                Visibility(
                  visible: title != null,
                  child: BaseText(
                    title,
                    size: FontSizes.xMid,
                    fontWeight: FontWeights.semiBold,
                    textColor: AppColors.secondary,
                    maxLines: 1,
                  ),
                ),
                //JUST TO PUT TITTLE IN CENTER
                const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                width: 343.w,
                height: height,
                constraints: BoxConstraints(maxHeight: 660.h, minHeight: 300.h),
                margin: EdgeInsets.only(
                  top: 110.h,
                ),
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.primaryLight,
                        offset: Offset(0.0, 10.0), //(x,y)
                        blurRadius: 20.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(32.r)),
                child: child),
          )
        ],
      ),
    );
  }
}
