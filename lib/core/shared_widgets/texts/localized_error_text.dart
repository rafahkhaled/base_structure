import 'package:flutter/material.dart';
import 'package:base_structure/core/shared_widgets/texts/localized_text.dart';
import 'package:base_structure/core/singletons/app_colors.dart';

///Localized widget for easier access
class LocalizedTextError extends LocalizedText {
  // ignore: unused_field
  final bool _showError;

  LocalizedTextError(String super.localKey, this._showError,
      {double? size,
      Color? textColor = AppColors.red,
      super.textAlign,
      super.maxLines,
      super.textDecoration,
      FontWeight super.fontWeight,
      super.textHeight,
      super.textOverflow,
      super.softWrap,
      super.templatedValues,
      super.key})
      : super(
          textColor: _showError ? textColor : AppColors.transparent,
        );

  @override
  Widget build(BuildContext context) {
    if (_showError) {
      return super.build(context);
    } else {
      return const SizedBox.shrink();
    }
  }
}
