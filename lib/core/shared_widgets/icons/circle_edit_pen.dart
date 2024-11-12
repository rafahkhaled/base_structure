import 'package:base_structure/core/shared_widgets/images/general_image.dart';
import 'package:base_structure/core/shared_widgets/inkwell/transparent_inkwell.dart';
import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:base_structure/core/singletons/resource_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleEditPen extends StatelessWidget {
  final Function onTap;
  const CircleEditPen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TransparentInkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(9.r),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.secondary,
        ),
        child: const GeneralImage(
          url: ResourcePath.edit_pen_icon,
        ),
      ),
    );
  }
}
