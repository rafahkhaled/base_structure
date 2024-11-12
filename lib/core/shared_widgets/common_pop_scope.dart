import 'package:flutter/material.dart';

class CommonPopScope extends StatelessWidget {
  final Function(bool)? onPopInvoked;
  final Widget child;
  final bool? canPop;

  const CommonPopScope(
      {super.key,
      required this.onPopInvoked,
      required this.child,
      this.canPop});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        onPopInvoked?.call(didPop);
      },
      canPop: canPop ?? false,
      child: child,
    );
  }
}
