import 'package:base_structure/core/singletons/resource_path.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BtnLoading extends StatelessWidget {
  final double? width;
  final double? height;
  const BtnLoading({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(ResourcePath.loading_icon,
        width: width, height: height);
  }
}
