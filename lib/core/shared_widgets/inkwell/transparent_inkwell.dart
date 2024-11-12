import 'package:flutter/material.dart';
import 'package:base_structure/core/singletons/app_colors.dart';

class TransparentInkWell extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const TransparentInkWell(
      {super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      hoverColor: AppColors.transparent,
      onTap: onTap,
      child: child,
    );
  }
}
