import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/constant/api_constant.dart';
import 'package:tmdb_app/utils/assets_images_utils.dart';

class CacheNetworkImageWidget extends StatelessWidget {
  const CacheNetworkImageWidget(
      {Key? key,
      required this.image,
      this.fit = BoxFit.contain,
      this.height,
      this.width})
      : super(key: key);
  final String image;
  final BoxFit fit;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit,
      imageUrl: (image.isEmpty) ? kDefaultImage : '$kImagePrefixLink$image',
      placeholder: (_, __) => Image.asset(
        AssetsImagesUtils.kTMDBImagePlaceHolder,
        fit: fit,
      ),
    );
  }
}
