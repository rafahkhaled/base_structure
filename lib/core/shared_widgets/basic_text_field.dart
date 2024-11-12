// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:base_structure/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:base_structure/core/singletons/app_colors.dart';

import 'package:base_structure/core/singletons/font_weights.dart';

class BasicTextField extends StatefulWidget {
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
  final bool showLabel;
  final double? height;
  final TextInputAction? textInputAction;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? textColor;
  final Color? hintColor;
  final double? textSize;
  final double? textHight;
  final FontWeight? fontWeight;

  const BasicTextField({
    super.key,
    this.icon,
    required this.controller,
    required this.hintTxt,
    this.isPassword = false,
    this.hintSize,
    this.minLines = 1,
    this.onSubmitted,
    this.textInputAction,
    this.inputType,
    this.isReadOnly = false,
    this.onChanged,
    this.prefix,
    this.height,
    this.textHight,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.showLabel = true,
    this.validator,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.hintColor,
  });

  @override
  _BasicTextFieldState createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
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
          key: widget.key,
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
              color: widget.textColor ?? AppColors.white,
              fontWeight: widget.fontWeight ?? FontWeights.medium,
              fontSize: widget.textSize ?? 25.sp,
              height: widget.textHight),
          decoration: InputDecoration(
            alignLabelWithHint: true,
            errorStyle: const TextStyle(
              fontWeight: FontWeights.medium,
              fontSize: 10,
              color: AppColors.secondary,
            ),
            isDense: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color:
                      widget.enabledBorderColor ?? AppColors.XlightWhiteColor,
                  width: 1.5),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color:
                      widget.focusedBorderColor ?? AppColors.XlightWhiteColor,
                  width: 1.5),
            ),
            filled: true,
            hintStyle: TextStyle(
              color: widget.hintColor ?? AppColors.fontHint.withOpacity(.33),
              fontWeight: FontWeights.medium,
              fontSize: widget.hintSize ?? 25.sp,
            ),
            hintText: Utils.parseLocalizedKey(widget.hintTxt),
            fillColor: AppColors.transparent,
            errorMaxLines: 3,
            suffixIcon: widget.icon,
            prefixIcon: widget.prefix,
          ),
        ),
      ),
    );
  }
}
