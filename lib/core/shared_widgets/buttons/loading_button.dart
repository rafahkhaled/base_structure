import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_structure/core/shared_widgets/buttons/custom_elevation_button.dart';

import 'package:base_structure/core/singletons/resource_path.dart';

class LoadingButton extends StatefulWidget {
  final TaskCallback<Future?> onPressed;
  final Widget child;
  final double? height;
  final Color disabledButtonColor;
  final double? width;
  final String? fontFamily;
  final Color color;
  final Color borderColor;
  final Color defaultLoaderColor;
  final Color disabledBorderColor;
  final double disabledElevation;
  final double? fontSize;
  final double elevation;
  final double? borderWidth;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry buttonPadding;
  final Size? minimumSize;
  final Size? maximumSize;
  final bool enable;
  final String loadingImagePath;
  final Widget? loadingChild;
  final double? loadingImageWidth;
  const LoadingButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.height,
    this.fontFamily,
    this.width,
    this.disabledButtonColor = AppColors.grey,
    this.disabledBorderColor = AppColors.grey,
    this.color = AppColors.primary,
    this.borderColor = AppColors.primary,
    this.defaultLoaderColor = AppColors.white,
    this.disabledElevation = 0,
    this.fontSize,
    this.elevation = 1,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.buttonPadding = EdgeInsets.zero,
    this.minimumSize,
    this.maximumSize,
    this.enable = true,
    this.loadingImagePath = ResourcePath.dotted_loading_gif,
    this.loadingImageWidth,
    this.loadingChild,
  });

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  ///A flag to check if the button has been triggerd to take action
  bool _isTriggered = false;
  bool get isTriggered => _isTriggered;

  _LoadingButtonState();

  void _updateTriggered(bool isTriggered) {
    setState(() {
      _isTriggered = isTriggered;
    });
  }

  Widget getLoaderOrDefault() =>
      widget.loadingChild ??
      Image.asset(
        widget.loadingImagePath,
        width: widget.loadingImageWidth ?? 30.w,
        color: widget.defaultLoaderColor,
        fit: BoxFit.cover,
      );

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        if (!_isTriggered) {
          _updateTriggered(true);

          if (widget.enable) {
            try {
              await widget.onPressed();
            } catch (_) {}
          }

          _updateTriggered(false);
        }
      },
      height: widget.height,
      width: widget.width,
      borderColor:
          !widget.enable ? widget.disabledBorderColor : widget.borderColor,
      borderRadius: widget.borderRadius,
      borderWidth: widget.borderWidth,
      color: !widget.enable ? widget.disabledButtonColor : widget.color,
      key: widget.key,
      padding: widget.padding,
      child: _isTriggered ? getLoaderOrDefault() : widget.child,
    );
  }
}
