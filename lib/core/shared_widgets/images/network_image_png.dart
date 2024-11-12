import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_structure/core/shared_widgets/dialogs/app_dialog.dart';
import 'package:base_structure/core/shared_widgets/inkwell/transparent_inkwell.dart';
import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:base_structure/core/singletons/resource_path.dart';
import 'package:photo_view/photo_view.dart';

///Create an image or provide a widget or path to a fallback value
///[failWidget] the widget to show if loading of image faild
///[placeHolderWhileLoading] the widget to show while loading the image
class NetworkImagePng extends StatefulWidget {
  static Widget loadingDefault = Image.asset(
    ResourcePath.dotted_loading_gif,
    height: 50.r,
    width: 50.r,
  );
  final BoxShape? boxShape;
  final Widget? failWidget;
  final String url;
  final BoxFit boxFit;
  final double? height;
  final double? width;
  final Widget? placeHolderWhileLoading;
  final Color? color;
  final bool clickableImage;

  const NetworkImagePng({
    super.key,
    required this.url,
    this.failWidget,
    this.height,
    this.width,
    this.boxShape,
    this.boxFit = BoxFit.cover,
    this.placeHolderWhileLoading,
    this.color,
    this.clickableImage = false,
  });

  @override
  State<NetworkImagePng> createState() => _NetworkImagePngState();
}

class _NetworkImagePngState extends State<NetworkImagePng> {
  late String _url;
  @override
  void initState() {
    _url = widget.url;

    super.initState();
  }

  //when app can't ,load image
  Widget errorBuilder(
      BuildContext context, Object exception, dynamic stackTrace) {
    return widget.failWidget ?? const Icon(Icons.error);
  }

  @override
  Widget build(BuildContext context) {
    return !widget.clickableImage
        ? CachedNetworkImage(
            imageUrl: _url,
            height: widget.height,
            width: widget.width,
            fit: widget.boxFit,
            color: widget.color,
            errorWidget: errorBuilder,
            imageBuilder: (context, imageProvider) => Container(
              width: widget.height,
              height: widget.height,
              decoration: BoxDecoration(
                shape: widget.boxShape ?? BoxShape.rectangle,
                image:
                    DecorationImage(image: imageProvider, fit: widget.boxFit),
              ),
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: SizedBox(
                width: widget.height ?? 0 / 2,
                height: widget.height ?? 0 / 2,
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: AppColors.primary,
                ),
              ),
            ),
          )
        : TransparentInkWell(
            onTap: () => showAppDialog(
              height: 0.5.sh,
              width: 0.5.sw,
              backgroundColor: AppColors.transparent,
              context: context,
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: PhotoView(
                backgroundDecoration:
                    const BoxDecoration(color: AppColors.transparent),
                imageProvider: NetworkImage(
                  _url,
                ),
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: _url,
              color: widget.color,
              height: widget.height,
              width: widget.width,
              fit: widget.boxFit,
              imageBuilder: (context, imageProvider) => Container(
                width: widget.height,
                height: widget.height,
                decoration: BoxDecoration(
                  shape: widget.boxShape ?? BoxShape.rectangle,
                  image:
                      DecorationImage(image: imageProvider, fit: widget.boxFit),
                ),
              ),
              errorWidget: errorBuilder,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: SizedBox(
                  width: widget.height ?? 0 / 2,
                  height: widget.height ?? 0 / 2,
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
              ),
            ),
          );
  }
}
