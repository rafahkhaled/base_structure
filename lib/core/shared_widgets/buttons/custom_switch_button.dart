import 'package:base_structure/core/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:base_structure/core/singletons/animation_durations.dart';
import 'package:base_structure/core/singletons/app_colors.dart';

class CustomSwitchButton extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enable;
  final Color activeColor;

  const CustomSwitchButton(
      {super.key,
      required this.value,
      required this.onChanged,
      this.enable = true,
      this.activeColor = AppColors.primary});

  @override
  State<CustomSwitchButton> createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: AnimationDurations.normal);
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        var disable = !widget.value;

        return GestureDetector(
          onTap: () {
            if (!widget.enable) {
              return;
            }
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 34.w,
            height: 18.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              color: disable ? AppColors.grey : widget.activeColor,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 2.h,
                bottom: 2.h,
              ),
              child: Container(
                alignment: widget.value
                    ? (!Utils.isRTL()
                        ? Alignment.centerRight
                        : Alignment.centerLeft)
                    : (!Utils.isRTL()
                        ? Alignment.centerLeft
                        : Alignment.centerRight),
                child: Container(
                  width: 20.r,
                  height: 20.r,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
