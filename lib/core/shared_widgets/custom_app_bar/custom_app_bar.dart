import 'package:base_structure/core/domain/navigation/inavigation_controller.dart';
import 'package:base_structure/core/shared_widgets/texts/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:base_structure/core/singletons/font_sizes.dart';
import 'package:base_structure/core/singletons/font_weights.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLeading;
  final Widget? leadingWidget;
  final Widget? actionWidget;
  final bool showTitle;
  final Widget? titleWidget;
  final String? title;
  final Function? onBackFun;
  final Color backgroundColor;
  final bool enableNavigateBack;
  final double appBarHeight;

  CustomAppBar(
      {super.key,
      this.leadingWidget,
      this.showLeading = true,
      this.showTitle = true,
      this.onBackFun,
      this.enableNavigateBack = true,
      this.title,
      this.backgroundColor = AppColors.primary,
      this.actionWidget,
      this.appBarHeight = 0,
      this.titleWidget})
      : preferredSize = Size.fromHeight(kToolbarHeight + appBarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    var navigationController = Get.find<INavigationController>();
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor,
      centerTitle: true,
      leading: leadingWidget ??
          (showLeading
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.primary,
                  ),
                  padding: EdgeInsets.zero,
                  color: AppColors.primary,
                  iconSize: 24.r,
                  onPressed: () {
                    onBackFun?.call();
                    if (enableNavigateBack) {
                      Navigator.canPop(context)
                          ? navigationController.navigateBack()
                          : navigationController
                              .navigateAsync(NavigatePage.HOME);
                    }
                  },
                )
              : const SizedBox()),
      title: titleWidget ??
          (showTitle
              ? LocalizedText(
                  title,
                  size: FontSizes.xMid,
                  fontWeight: FontWeights.semiBold,
                  textColor: AppColors.secondary,
                  maxLines: 1,
                )
              : const SizedBox()),
      actions: [actionWidget ?? const SizedBox()],
    );
  }
}
