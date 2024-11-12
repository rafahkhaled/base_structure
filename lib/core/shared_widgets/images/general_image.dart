import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:base_structure/core/shared_widgets/images/general_network_image.dart';

class GeneralImage extends StatelessWidget {
  final Widget? failWidget;
  final String url;
  final BoxFit boxFit;
  final double? height;
  final double? width;
  final Widget? placeHolderWhileLoading;
  final Color? color;
  final double borderRadius;
  final bool clickableImage;
  final bool isNetworkImgClipped;
  final BoxShape? boxShape;
  final bool matchTextDirection;
  final AlignmentGeometry? alignment;

  const GeneralImage({
    super.key,
    required this.url,
    this.failWidget,
    this.height,
    this.borderRadius = 0,
    this.width,
    this.boxShape,
    this.boxFit = BoxFit.cover,
    this.placeHolderWhileLoading,
    this.clickableImage = false,
    this.isNetworkImgClipped = false,
    this.color,
    this.matchTextDirection = true,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return url.startsWith("http")
        ? isNetworkImgClipped
            ? ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: GeneralNetworkImage(
                  width: width,
                  height: height,
                  url: url,
                  boxShape: boxShape,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: color == null
                        ? null
                        : Border.all(width: 2.w, color: color!)),
                child: GeneralNetworkImage(
                  borderRadius: borderRadius,
                  width: width,
                  height: height,
                  boxFit: boxFit,
                  url: url,
                  boxShape: boxShape,
                ),
              )
        : url.endsWith(".svg")
            ? SvgPicture.asset(url,
                color: color,
                width: width,
                height: height,
                fit: boxFit,
                matchTextDirection: matchTextDirection,
                alignment: alignment ?? Alignment.center)
            : url.endsWith(".png")
                ? Image.asset(url,
                    color: color,
                    width: width,
                    height: height,
                    fit: boxFit,
                    matchTextDirection: matchTextDirection,
                    alignment: alignment ?? Alignment.center)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Image.file(
                      File(
                        url,
                      ),
                      width: width,
                      height: height ?? 50,
                      fit: BoxFit.cover,
                      matchTextDirection: matchTextDirection,
                    ),
                  );
  }
}
