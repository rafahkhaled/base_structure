import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:base_structure/core/shared_widgets/images/general_image.dart';

///Create an image or provide a widget or path to a fallback value
///[failWidget] the widget to show if loading of image faild
///[placeHolderWhileLoading] the widget to show while loading the image
class NetworkImageSvg extends StatelessWidget {
  static Widget fallbackFlag = const GeneralImage(url: "forget_data");
  static Widget loadingDefault = Image.asset(
    "forget_data",
    height: 50,
    width: 50,
  );

  final Widget? failWidget;
  final String url;
  final BoxFit boxFit;
  final double? height;
  final double? width;
  final Widget? placeHolderWhileLoading;
  final Color? color;

  //when app can't ,load image
  Widget errorBuilder(
      BuildContext context, Object exception, StackTrace? stackTrace) {
    return failWidget ?? fallbackFlag;
  }

  //while app load the image
  Widget loadingBuilder(BuildContext context) {
    return Center(child: placeHolderWhileLoading ?? loadingDefault);
  }

  const NetworkImageSvg({
    super.key,
    required this.url,
    this.failWidget,
    this.height = 50,
    this.width = 50,
    this.boxFit = BoxFit.cover,
    this.placeHolderWhileLoading,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      url,
      color: color,
      height: height,
      width: width,
      fit: boxFit,
    );
  }
}
