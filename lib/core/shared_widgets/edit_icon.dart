import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:flutter/cupertino.dart';

class EditIcon extends StatelessWidget {
  const EditIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: AppColors.red,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          CupertinoIcons.minus,
          color: AppColors.white,
        ));
  }
}
