import 'package:base_structure/core/shared_widgets/texts/localized_text.dart';
import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:base_structure/core/singletons/font_sizes.dart';
import 'package:base_structure/core/singletons/font_weights.dart';
import 'package:base_structure/core/singletons/resource_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SuccessDialog extends StatelessWidget {
  final String localizedKey;
  const SuccessDialog({super.key, required this.localizedKey});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 22.h),
        width: 310.w,
        height: 218,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(ResourcePath.success_animation,
                height: 91.r, width: 91.r),
            LocalizedText(
              localizedKey,
              fontWeight: FontWeights.medium,
              size: FontSizes.large,
              textColor: AppColors.primary,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    ));
  }
}
