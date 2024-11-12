// ignore_for_file: library_private_types_in_public_api

import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_structure/core/shared_widgets/inkwell/transparent_inkwell.dart';

class LoadingTransparentInkWell extends StatefulWidget {
  final Future<void> Function() onTap;
  final Widget child;
  final Widget? loadingChild;

  const LoadingTransparentInkWell({
    required this.onTap,
    required this.child,
    this.loadingChild,
    super.key,
  });

  @override
  _LoadingTransparentInkWellState createState() =>
      _LoadingTransparentInkWellState();
}

class _LoadingTransparentInkWellState extends State<LoadingTransparentInkWell> {
  bool _isLoading = false;

  void _setLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TransparentInkWell(
      onTap: () async {
        if (!_isLoading) {
          _setLoading(true);
          try {
            await widget.onTap();
          } finally {
            _setLoading(false);
          }
        }
      },
      child: _isLoading
          ? widget.loadingChild ??
              Container(
                  width: 24.r,
                  height: 24.r,
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4.r)),
                  child: Transform.scale(
                    scale: 0.6.r,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 4.r,
                    ),
                  ))
          : widget.child,
    );
  }
}
