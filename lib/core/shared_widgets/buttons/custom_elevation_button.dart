import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_structure/core/shared_widgets/inkwell/transparent_inkwell.dart';
import 'package:base_structure/core/singletons/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double? height;
  final Color disabledButtonColor;
  final double? width;
  final String? fontFamily;
  final Color? color;
  final Color borderColor;
  final Color disabledBorderColor;
  final double disabledElevation;
  final double? borderWidth;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool enable;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.height,
    this.fontFamily,
    this.width,
    this.disabledButtonColor = AppColors.grey,
    this.disabledBorderColor = AppColors.grey,
    this.color,
    this.borderColor = AppColors.secondary,
    this.disabledElevation = 0,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return TransparentInkWell(
      onTap: () => enable ? onPressed() : null,
      child: Container(
        width: width ?? 300.w,
        height: height ?? 48.h,
        padding: padding,
        margin: EdgeInsets.zero,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
          border: Border.all(
              width: borderWidth ?? 1,
              color: enable ? borderColor : AppColors.grey),
          gradient: color == null
              ? LinearGradient(
                  colors: [
                      enable ? AppColors.btnColor1 : AppColors.lightGrey,
                      enable ? AppColors.btnColor2 : AppColors.grey,
                    ],
                  stops: const [
                      0.0,
                      1.0
                    ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  tileMode: TileMode.repeated)
              : null,
        ),
        child: Center(child: child),
      ),
    );
  }
}
