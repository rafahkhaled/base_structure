// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_structure/core/shared_widgets/dialogs/app_alert_dialog.dart';
import 'package:base_structure/core/shared_widgets/images/general_image.dart';
import 'package:base_structure/core/shared_widgets/spaces/custom_space.dart';
import 'package:base_structure/core/shared_widgets/texts/localized_text.dart';
import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:base_structure/core/singletons/font_sizes.dart';
import 'package:base_structure/core/singletons/icon_sizes.dart';

///A timed message dialog that will hide it self after [duration]
showAppLocalizedTimedMessageDialog(
    {required BuildContext dialogContext,
    double? height,
    double? width,
    Border? border,
    double? borderRadius,
    EdgeInsets? margin,
    EdgeInsets? padding,
    Color? backgroundColor,
    String? localizedKey,
    String? assetPathSvg,
    String? assetPathGif,
    bool? isSensitiveText,
    List<Object>? templatedValues,
    Function? onAfterDuration,
    bool autoClose = true,
    bool barrierDismissible = true,
    Duration duration = const Duration(seconds: 5),
    Widget? child}) {
  showDialog(
    context: dialogContext,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      //duration for dialog to show
      Future.delayed(duration, () {
        if (autoClose) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
        onAfterDuration?.call();
      });
      return AppAlertDialog(
        height: height,
        width: width,
        border: border,
        borderRadius: borderRadius,
        margin: margin,
        padding: padding,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(56.r),
        ),
        child: child ??
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                assetPathGif == null && assetPathSvg == null
                    ? GeneralImage(
                        url: " ResourcePath.information_circle_icon_svg",
                        height: IconSizes.xLarge,
                        width: IconSizes.xLarge,
                        color: AppColors.primary,
                      )
                    : assetPathSvg == null
                        ? Image.asset(
                            assetPathGif!,
                            height: IconSizes.xLarge,
                            color: AppColors.primary,
                          )
                        : GeneralImage(
                            url: assetPathSvg,
                            height: IconSizes.xLarge,
                            width: IconSizes.xLarge,
                            color: AppColors.primary,
                          ),
                smallSpaceH(),
                LocalizedText(
                  localizedKey,
                  isSensitiveText: isSensitiveText,
                  textAlign: TextAlign.center,
                  templatedValues: templatedValues,
                  size: FontSizes.xMid,
                ),
              ],
            ),
      );
    },
  );
}
