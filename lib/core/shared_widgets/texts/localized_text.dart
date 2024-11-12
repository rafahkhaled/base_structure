import 'package:base_structure/core/shared_widgets/texts/base_text.dart';
import 'package:base_structure/core/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Localized widget for easier access
class LocalizedText extends BaseText {
  final String? nLocalizeKey;
  final List<Object>? nTemplatedValues;
  LocalizedText(String? localizeKey,
      {double? size,
      Color? textColor,
      Color? iconColor,
      TextAlign? textAlign,
      bool? isSensitiveText,
      int? maxLines = 100,
      TextDecoration? textDecoration,
      FontWeight? fontWeight = FontWeight.w400,
      double? textHeight,
      TextOverflow? textOverflow = TextOverflow.ellipsis,
      bool? softWrap = true,
      List<Object>? templatedValues,
      String? iconPath,
      Icon? prefixIcon,
      bool toUpperCase = false,
      SizedBox? iconTextSpace,
      double? iconSize,
      Key? key})
      : nLocalizeKey = localizeKey,
        nTemplatedValues = templatedValues,
        super(
          Utils.parseLocalizedKey(localizeKey,
              templatedValues: templatedValues, toUpperCase: toUpperCase),
          textColor: textColor,
          textAlign: textAlign,
          maxLines: maxLines,
          isSensitiveText: isSensitiveText,
          textDecoration: textDecoration,
          fontWeight: fontWeight,
          iconSize: iconSize,
          textHeight: textHeight,
          textOverflow: textOverflow,
          softWrap: softWrap,
          size: size,
          key: key,
          iconTextSpace: iconTextSpace,
          prefixIcon: prefixIcon,
          iconPath: iconPath,
          iconColor: iconColor,
        );
}
