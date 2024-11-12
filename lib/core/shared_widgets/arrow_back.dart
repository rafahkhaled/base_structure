import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:flutter/material.dart';

class ArrowBack extends StatelessWidget {
  final Color? color;
  const ArrowBack({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_back,
      color: color ?? AppColors.white,
    );
  }
}
