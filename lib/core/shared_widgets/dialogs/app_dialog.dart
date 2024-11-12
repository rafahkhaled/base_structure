import 'package:flutter/material.dart';
import 'package:base_structure/core/shared_widgets/common_pop_scope.dart';
import 'package:base_structure/core/shared_widgets/dialogs/app_alert_dialog.dart';

/// main dialog in the app
void showAppDialog({
  required BuildContext context,
  double? height,
  double? width,
  Border? border,
  double? borderRadius,
  EdgeInsets? margin,
  EdgeInsets? padding,
  Color? backgroundColor,
  ShapeBorder? shape,
  bool barrierDismissible = true,
  required Widget child,
}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => CommonPopScope(
      canPop: true,
      onPopInvoked: (onDidPop) async => barrierDismissible,
      child: AppAlertDialog(
        height: height,
        width: width,
        border: border,
        borderRadius: borderRadius,
        margin: margin,
        padding: padding,
        shape: shape,
        backgroundColor: backgroundColor,
        child: child,
      ),
    ),
  );
}
