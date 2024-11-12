import 'package:base_structure/core/domain/navigation/inavigation_controller.dart';
import 'package:base_structure/core/shared_widgets/inkwell/transparent_inkwell.dart';
import 'package:base_structure/core/shared_widgets/texts/base_text.dart';
import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:base_structure/core/singletons/font_sizes.dart';
import 'package:base_structure/core/singletons/font_weights.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommonScaffold extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final Widget? action;
  final String? title;
  final bool showBackBtn;
  final EdgeInsetsGeometry? padding;
  final bool safeBottom;
  final Color? backGroundColor;

  CommonScaffold(
      {super.key,
      required this.child,
      this.title,
      this.action,
      this.leading,
      this.safeBottom = true,
      this.showBackBtn = false,
      this.padding,
      this.backGroundColor});
  final navigationController = Get.find<INavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backGroundColor ?? AppColors.backGroundColor,
      body: SafeArea(
        bottom: safeBottom,
        child: Padding(
            padding:
                padding ?? EdgeInsets.only(right: 30.w, left: 30.w, top: 15.h),
            child: Column(
              children: [
                Visibility(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      leading ??
                          (showBackBtn
                              ? TransparentInkWell(
                                  onTap: () {
                                    navigationController.navigateBack();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios_rounded,
                                    color: AppColors.white,
                                  ),
                                )
                              : const SizedBox()),
                      Expanded(
                        child: BaseText(
                          title,
                          fontWeight: FontWeights.semiBold,
                          textColor: AppColors.white,
                          size: FontSizes.large,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ),
                      action ?? const SizedBox.shrink(),
                    ],
                  ),
                ),
                child,
              ],
            )),
      ),
    );
  }
}
