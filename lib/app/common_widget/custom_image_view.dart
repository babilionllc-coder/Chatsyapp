// ignore_for_file: must_be_immutable, deprecated_member_use

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatsy/app/helper/app_colors.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/app/helper/safe_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../modules/chat_gpt/views/chat_gpt_view.dart';

class ImageSize {
  ImageSize({this.alignment, this.dimension, this.height, this.width});

  final Alignment? alignment;
  final double? dimension;
  final double? height;
  final double? width;

  Widget _makeWidgetCompatible(Widget child) {
    var temp = child;
    if (alignment != null) {
      temp = Align(alignment: alignment!, child: child);
    }
    if (dimension != null) {
      return SizedBox.square(dimension: dimension, child: temp);
    }

    if (height != null && width != null) {
      return SizedBox(height: height, width: width, child: temp);
    }

    return temp;
  }
}

extension DecorationX on Decoration {
  Decoration apply(BorderRadius? borderRadius, Color? color, BoxShape? shape) {
    if (this is BoxDecoration) {
      final boxDecoration = this as BoxDecoration;
      return boxDecoration.copyWith(
        borderRadius: boxDecoration.borderRadius ?? borderRadius,
        color: boxDecoration.color ?? color,
        shape: shape ?? boxDecoration.shape,
      );
    }
    return this;
  }
}

class ImageView extends StatelessWidget {
  ImageView(
    this.imagePath, {
    super.key,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.color,
    Widget? errorWidget,
    Color? backgroundColor,
    Decoration? decoration,
    this.alignment,
    this.fit = BoxFit.cover,
    this.inner,
    this.outer,
  }) : _decoration =
           decoration?.apply(borderRadius, backgroundColor, shape) ??
           BoxDecoration(
             shape: shape,
             color: backgroundColor,
             borderRadius: borderRadius,
           ),
       errorWidget =
           errorWidget ??
           Image.asset((isLight) ? ImagePath.darkLogo : ImagePath.logo);

  final AlignmentGeometry? alignment;

  final BoxFit fit;

  final String imagePath;

  final ImageSize? inner;
  final ImageSize? outer;

  final BorderRadius? borderRadius;

  final BoxShape shape;
  final Widget? errorWidget;

  final Color? color;

  final Decoration _decoration;

  @override
  Widget build(BuildContext context) {
    final type = imagePath.imageType;
    var widget = switch (type) {
      ImageType.svg => _SvgIcon(imagePath, color: color, fit: fit),
      ImageType.asset => ImageAsset(
        imagePath,
        color: color,
        fit: fit,
        errorWidget: errorWidget,
      ),
      ImageType.network => SafeImageWidget(
        imageUrl: imagePath,
        fit: fit,
        errorWidget: errorWidget,
      ),
      ImageType.file => ImageFile(
        imagePath,
        color: color,
        fit: fit,
        errorWidget: errorWidget,
      ),
    };

    widget = inner?._makeWidgetCompatible(widget) ?? widget;

    widget = outer?._makeWidgetCompatible(widget) ?? widget;

    if ((_decoration is BoxDecoration) && _decoration.borderRadius != null) {
      widget = _checkBoundaries(widget, _decoration.borderRadius);
    } else {
      widget = _checkBoundaries(widget, null);
    }

    return DecoratedBox(decoration: _decoration, child: widget);
  }

  Widget _checkBoundaries(Widget widget, BorderRadiusGeometry? borderRadius) {
    if (shape == BoxShape.circle) {
      return ClipOval(child: widget);
    } else if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius, child: widget);
    }
    return widget;
  }
}

class ImageFile extends Image {
  ImageFile(
    String assetName, {
    super.key,
    super.color,
    super.fit,
    Widget? errorWidget,
  }) : super(
         image: FileImage(File(assetName)),
         loadingBuilder: (context, child, loadingProgress) {
           if (loadingProgress == null) {
             return child;
           }

           double? progress;

           if (loadingProgress.expectedTotalBytes != null) {
             progress =
                 loadingProgress.cumulativeBytesLoaded /
                 loadingProgress.expectedTotalBytes!;
             return AppProgressIndicator(value: progress);
           }

           return const AppProgressIndicator();
         },
         errorBuilder: (context, error, stackTrace) {
           return errorWidget ?? const Icon(Icons.error);
         },
       );
}

class NetworkImage extends CachedNetworkImage {
  NetworkImage(
    String imageUrl, {
    super.key,
    super.color,
    super.fit,
    Widget? errorWidget,
  }) : super(
         imageUrl: imageUrl,
         placeholder: (context, url) {
           return progressIndicatorView(borderRadius: 10);
         },
         errorWidget:
             (context, url, error) => errorWidget ?? const Icon(Icons.error),
       );
}

class AppProgressIndicator extends CircularProgressIndicator {
  const AppProgressIndicator({
    super.key,
    super.value,
    super.strokeCap = StrokeCap.round,
    super.strokeWidth = 2,
  });
}

class ImageAsset extends Image {
  ImageAsset(
    String assetName, {
    super.key,
    super.color,
    super.fit,
    Widget? errorWidget,
  }) : super(
         image: AssetImage(assetName),
         loadingBuilder: (context, child, loadingProgress) {
           if (loadingProgress == null) {
             return child;
           }

           double? progress;

           if (loadingProgress.expectedTotalBytes != null) {
             progress =
                 loadingProgress.cumulativeBytesLoaded /
                 loadingProgress.expectedTotalBytes!;
             return AppProgressIndicator(value: progress);
           }

           return const AppProgressIndicator();
         },
         errorBuilder: (context, error, stackTrace) {
           return errorWidget ?? const Icon(Icons.error);
         },
       );
}

class _SvgIcon extends SvgPicture {
  _SvgIcon(
    String assetName, {
    AssetBundle? bundle,
    String? package,
    SvgTheme? theme,
    Color? color,
    super.fit,
  }) : super(
         SvgAssetLoader(
           assetName,
           packageName: package,
           assetBundle: bundle,
           theme: theme,
         ),
         colorFilter:
             color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
       );
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    }
    if (endsWith('.svg')) {
      return ImageType.svg;
    }
    if (startsWith('asset')) {
      return ImageType.asset;
    }
    return ImageType.file;
  }
}

enum ImageType { svg, asset, network, file }
