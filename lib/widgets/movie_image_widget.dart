import 'package:flutter/material.dart';
import 'package:tmdb_app/constant/dimens.dart';
import 'package:tmdb_app/widgets/cache_network_image_widget.dart';

class MovieImageWidget extends StatelessWidget {
  const MovieImageWidget({super.key, required this.imageURL});

  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kSP20x),
      child: CacheNetworkImageWidget(
        image: imageURL,
        fit: BoxFit.cover,
      ),
    );
  }
}
