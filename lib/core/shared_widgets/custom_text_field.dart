// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:base_structure/core/singletons/font_sizes.dart';
import 'package:base_structure/core/singletons/font_weights.dart';

class CustomTextField extends StatefulWidget {
  final Widget? icon;
  final TextEditingController? controller;
  final String? hintTxt;
  final bool? isPassword;
  final double? hintSize;
  final int? minLines;
  final bool? isReadOnly;
  final Widget? prefix;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final Color? backgroundColor;
  final double? height;
  final TextInputAction? textInputAction;
  final Color? borderColor;
  final bool showLabel;
  final double? borderRadius;

  const CustomTextField({
    super.key,
    this.icon,
    required this.controller,
    required this.hintTxt,
    this.isPassword = false,
    this.hintSize,
    this.minLines = 1,
    this.onSubmitted,
    this.textInputAction,
    this.backgroundColor,
    this.inputType,
    this.isReadOnly = false,
    this.onChanged,
    this.prefix,
    this.height,
    this.borderColor,
    this.showLabel = true,
    this.borderRadius,
    this.validator,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: widget.height,
        child: TextFormField(
          // onTap: _requestFocus,
          focusNode: _focusNode,
          cursorColor: AppColors.primary,
          controller: widget.controller,
          obscureText: widget.isPassword ?? false,
          minLines: widget.minLines,
          maxLines: widget.minLines,
          keyboardType: widget.inputType ?? TextInputType.text,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          readOnly: widget.isReadOnly ?? false,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          onFieldSubmitted: widget.onSubmitted,
          onChanged: widget.onChanged,

          style: TextStyle(
            fontWeight: FontWeights.medium,
            fontSize: widget.hintSize ?? FontSizes.mid,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            alignLabelWithHint: true,
            errorStyle: TextStyle(
              fontWeight: FontWeights.medium,
              fontSize: 10,
              color: Colors.red[900],
            ),
            isDense: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 16.r),
              borderSide: BorderSide(color: AppColors.primary, width: 1.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 16.r),
              borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.primaryLight,
                width: 1.w,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 16.r),
              borderSide: BorderSide(color: AppColors.red, width: 1.w),
            ),
            filled: true,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeights.medium,
              fontSize: widget.hintSize ?? FontSizes.mid,
            ),
            hintText: widget.hintTxt,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 16.r),
              borderSide: BorderSide(color: AppColors.red, width: 1.w),
            ),
            fillColor: widget.backgroundColor ?? AppColors.primaryBright,
            errorMaxLines: 3,
            suffixIcon: widget.icon,
            prefixIcon: widget.prefix,
          ),
        ),
      ),
    );
  }
}
