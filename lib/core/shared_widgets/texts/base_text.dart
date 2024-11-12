import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_structure/core/shared_widgets/images/general_image.dart';
import 'package:base_structure/core/shared_widgets/spaces/custom_space.dart';
import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:base_structure/core/singletons/font_sizes.dart';
import 'package:base_structure/core/singletons/font_weights.dart';
import 'package:base_structure/core/singletons/icon_sizes.dart';

///Localized widget for easier access
class BaseText extends StatelessWidget {
  static const String _parseGroupRegexTemplate =
      r"(<b>(?<bold>.+?)<\/b>|<i>(?<italic>.+?)<\/i>|<u>(?<underline>.+?)<\/u>|<s>(?<s30b600ac>.+?)<\/s>|<d>(?<smallBlack>.+?)<\/d>|<x>(?<s31b601ac>.+?)<\/x>|<X>(?<s32b602ac>.+?)<\/X>)";
  static final RegExp _parseGroupRegExp = RegExp(_parseGroupRegexTemplate);

  static final _customTextSpans = <String, Function>{
    //bold
    '<b>': (String text) => TextSpan(
        text: text, style: const TextStyle(fontWeight: FontWeight.w600)),
    //underline
    '<u>': (String text) => TextSpan(
        text: text,
        style:
            const TextStyle(decoration: TextDecoration.underline)), //underline
    '<i>': (String text) => TextSpan(
        text: text, style: const TextStyle(fontStyle: FontStyle.italic)),
    //size 30 and bold 600 with app colors
    '<S>': (String text) => TextSpan(
        text: text,
        style: TextStyle(
            fontSize: 30.sp,
            color: AppColors.red,
            fontWeight: FontWeight.w600)),
    //size 14 and semibold with app colors
    '<s>': (String text) => TextSpan(
        text: text,
        style: TextStyle(
            fontSize: FontSizes.mid,
            color: AppColors.red,
            fontWeight: FontWeights.semiBold)),
    //size 10 and medium with app colors
    '<x>': (String text) => TextSpan(
        text: text,
        style: TextStyle(
            fontSize: FontSizes.xSmall,
            color: AppColors.red,
            fontWeight: FontWeights.medium)),
    //size 12 and medium with app primary color
    '<X>': (String text) => TextSpan(
        text: text,
        style: TextStyle(
            fontSize: FontSizes.small,
            color: AppColors.primary,
            fontWeight: FontWeights.medium)),

    //size 14 and semibold with app colors(Font-dark)
    '<d>': (String text) => TextSpan(
        text: text,
        style: TextStyle(
            fontSize: FontSizes.mid,
            color: AppColors.black,
            fontWeight: FontWeights.semiBold)),
    //Default case
    '_d': (String text) => TextSpan(text: text)
  };
  final String? _value;
  final double? size;
  final Color? textColor;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextDecoration? textDecoration;
  final FontWeight? fontWeight;
  final double? textHeight;
  final TextOverflow? textOverflow;
  final bool? softWrap;
  final String? iconPath;
  final Color? iconColor;
  final Icon? prefixIcon;
  final SizedBox? iconTextSpace;
  final double? iconSize;
  final bool? isSensitiveText;

  const BaseText(
    this._value, {
    this.size,
    this.textColor,
    this.textAlign,
    this.maxLines = 1000,
    this.textDecoration,
    this.fontWeight = FontWeight.w400,
    this.textHeight,
    this.textOverflow = TextOverflow.ellipsis,
    this.softWrap = true,
    this.iconPath,
    this.iconColor,
    this.iconSize,
    this.iconTextSpace,
    this.prefixIcon,
    this.isSensitiveText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var text = Text.rich(_parseRichText(_value ?? ""),
        maxLines: maxLines,
        overflow: textOverflow,
        softWrap: softWrap,
        textScaler: const TextScaler.linear(1),
        textAlign: textAlign,
        style: TextStyle(
            color: textColor,
            decoration: textDecoration,
            fontWeight: fontWeight,
            fontSize: size,
            height: textHeight));

    if (iconPath != null && iconPath != '') {
      return Row(
        mainAxisAlignment: textAlign != null && textAlign! == TextAlign.center
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          if (prefixIcon != null)
            prefixIcon!
          else
            SizedBox(
              width: 20.w,
              child: GeneralImage(
                url: iconPath!,
                color: iconColor,
                width: iconSize ?? IconSizes.medium,
                height: iconSize ?? IconSizes.medium,
              ),
            ),
          if (iconTextSpace != null) iconTextSpace!,
          Expanded(child: text)
        ],
      );
    }
    if (prefixIcon != null) {
      return Row(
        mainAxisAlignment: textAlign != null && textAlign! == TextAlign.center
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          xxSmallSpaceW(),
          prefixIcon!,
          if (iconTextSpace != null) iconTextSpace!,
          Expanded(child: text)
        ],
      );
    }
    return text;
  }

  static InlineSpan _parseRichText(String text) {
    //the parent element for all childeren that could be found in text
    var p = TextSpan(children: List<InlineSpan>.empty(growable: true));

    text.splitMapJoin(_parseGroupRegExp, onMatch: ((p0) {
      //Get the tag
      var tag = p0.group(0)?.substring(0, 3);
      //Check if we already have a styling for that tag
      if (_customTextSpans.containsKey(tag)) {
        //Create the inlinespan that is for it
        p.children!.add(_customTextSpans[tag]!(
            p0.input.substring(p0.start + 3, p0.end - 4)));
      } else {
        //eles just add as a default
        p.children!.add(_customTextSpans['_d']!(p0.group(0)));
      }
      // just return empty
      return '';
    }), onNonMatch: (p1) {
      if (p1 != "") {
        p.children!.add(_customTextSpans['_d']!(p1));
      }
      // just return empty
      return '';
    });
    Text.rich(p);
    return p;
  }
}
