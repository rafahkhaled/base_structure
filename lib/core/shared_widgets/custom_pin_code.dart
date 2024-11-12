// ignore_for_file: must_be_immutable

import 'package:base_structure/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:base_structure/core/singletons/font_weights.dart';
import 'package:pinput/pinput.dart';

class CustomPinCode extends StatefulWidget {
  final TextEditingController pinController;
  final void Function(String)? onSubmitted;
  const CustomPinCode(
      {super.key, required this.pinController, required this.onSubmitted});

  @override
  State<CustomPinCode> createState() => _CustomPinCodeState();
}

class _CustomPinCodeState extends State<CustomPinCode> {
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Utils.isRTL() ? TextDirection.rtl : TextDirection.ltr,
      child: Pinput(
          length: 6,
          controller: widget.pinController,
          focusNode: _focusNode,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.5, color: AppColors.secondary),
              ),
            ),
          ),
          showCursor: true,
          cursor: cursor,
          validator: (otp) {
            if (Utils.isStringNullOrEmpty(otp)) {
              return "Please enter your otp";
            } else if (otp!.length < 6) {
              return "Please enter valid otp";
            }
            return null;
          },
          onCompleted: widget.onSubmitted,
          onSubmitted: widget.onSubmitted),
    );
  }

  final length = 5;

  Color errorColor = AppColors.red;

  final defaultPinTheme = PinTheme(
    width: 40.w,
    height: 50.h,
    textStyle: TextStyle(
      color: AppColors.white,
      fontWeight: FontWeights.medium,
      fontSize: 25.sp,
    ),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 1.5, color: AppColors.primaryLight),
      ),
    ),
  );

  final cursor = Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: 21,
      height: 1,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(137, 146, 160, 1),
        shape: BoxShape.circle,
      ),
    ),
  );
}
