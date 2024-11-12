import 'package:flutter/material.dart';
import 'package:base_structure/core/shared_widgets/images/network_image_png.dart';
import 'package:base_structure/core/shared_widgets/images/network_image_svg.dart';
import 'package:base_structure/core/singletons/app_colors.dart';

class GeneralNetworkImage extends StatelessWidget {
  final Widget? failWidget;
  final String url;
  final BoxFit boxFit;
  final double? height;
  final double? width;
  final Widget? placeHolderWhileLoading;
  final Color? color;
  final double borderRadius;
  final bool clickableImage;
  final BoxShape? boxShape;
  final bool isGreyedOut;
  const GeneralNetworkImage({
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
    this.isGreyedOut = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    String? imgType = url.split('.').last;

    return ColorFiltered(
        colorFilter: ColorFilter.mode(
            isGreyedOut ? AppColors.white : AppColors.transparent,
            BlendMode.saturation),
        child: Opacity(
          opacity: isGreyedOut ? .75 : 1,
          child: imgType == "svg"
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: NetworkImageSvg(
                    url: url,
                    height: height,
                    width: width,
                    color: color,
                    boxFit: boxFit,
                    failWidget: failWidget,
                    placeHolderWhileLoading: placeHolderWhileLoading,
                  ),
                )
              :

              //This is for unit tests to not call network
              imgType == "" ||
                      imgType == "ut" ||
                      //Faker images
                      url.contains("source.unsplash.com")
                  ? Container()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: NetworkImagePng(
                        url: url,
                        height: height,
                        width: width,
                        boxShape: boxShape,
                        color: color,
                        boxFit: boxFit,
                        failWidget: failWidget,
                        clickableImage: clickableImage,
                        placeHolderWhileLoading: placeHolderWhileLoading,
                      ),
                    ),
        ));
  }
}
