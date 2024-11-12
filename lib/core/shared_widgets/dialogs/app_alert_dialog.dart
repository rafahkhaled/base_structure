import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_structure/core/singletons/app_colors.dart';

class AppAlertDialog extends StatelessWidget {
  final double? height;
  final double? width;
  final Border? border;
  final double? borderRadius;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final bool? scrollable;
  final ShapeBorder? shape;
  final AlignmentGeometry? alignment;
  final Widget child;
  const AppAlertDialog({
    super.key,
    this.height,
    this.width,
    this.scrollable,
    this.border,
    this.borderRadius,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.shape,
    required this.child,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      scrollable: scrollable ?? true,
      insetPadding: margin ?? EdgeInsets.symmetric(horizontal: 16.w),
      backgroundColor: AppColors.transparent,
      contentPadding: EdgeInsets.zero,
      shape: shape,
      content: Container(
        alignment: alignment ?? Alignment.center,
        width: width ?? 1.sw,
        height: height,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 19.w,
              vertical: 15.h,
            ),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.white,
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          border: border ?? Border.all(color: AppColors.transparent),
        ),
        child: child,
      ),
    );
  }
}
