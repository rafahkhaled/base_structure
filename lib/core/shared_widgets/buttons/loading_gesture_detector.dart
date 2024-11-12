import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:base_structure/core/singletons/app_colors.dart';

class LoadingGestureDetector extends StatefulWidget {
  final TaskCallback<Future?>? onPressed;
  final Widget? child;
  final double? height;
  final double? width;
  final Widget? loadingChild;
  final double? defaultLoaderHight;

  final Color defaultLoaderColor;

  const LoadingGestureDetector({
    super.key,
    this.onPressed,
    this.child,
    this.height,
    this.width,
    this.defaultLoaderColor = AppColors.white,
    this.defaultLoaderHight,
    this.loadingChild,
  });

  @override
  State<LoadingGestureDetector> createState() => _LoadingGestureDetectorState();
}

class _LoadingGestureDetectorState extends State<LoadingGestureDetector> {
  ///A flag to check if the button has been triggered to take action
  bool _isTriggered = false;

  _LoadingGestureDetectorState();

  void _updateTriggered(bool isTriggered) {
    setState(() {
      _isTriggered = isTriggered;
    });
  }

  Widget getLoaderOrDefault() =>
      widget.loadingChild ??
      Image.asset(
        "ResourcePath.dotted_loading_gif",
        width: widget.width,
        height: widget.defaultLoaderHight,
        color: widget.defaultLoaderColor,
        fit: BoxFit.cover,
      );

  @override
  Widget build(BuildContext context) {
    return _isTriggered
        ? getLoaderOrDefault()
        : GestureDetector(
            onTap: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              if (!_isTriggered) {
                _updateTriggered(true);

                if (widget.onPressed != null) {
                  await widget.onPressed!();
                }

                _updateTriggered(false);
              }
            },
            child: widget.child,
          );
  }
}
