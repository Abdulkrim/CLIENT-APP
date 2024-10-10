import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../generated/assets.dart';

class NetworkImageRounded extends StatelessWidget {
  const NetworkImageRounded(
      {super.key,
      required this.url,
      this.width,
      this.height,
      this.radius = const BorderRadius.all(Radius.circular(8)),
      this.padding = const EdgeInsets.all(0)});

  final String url;
  final double? width;
  final double? height;
  final BorderRadius radius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ClipRRect(
        borderRadius: radius,
        child: !kIsWeb
            ? CachedNetworkImage(
                height: height,
                width: width,
                imageUrl: url,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                  height: height,
                  width: width,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : url != ""
                ? FadeInImage.assetNetwork(
                    placeholder: Assets.bgPlaceholderImage,
                    image: url,
                    fadeOutDuration: const Duration(milliseconds: 10),
                    fit: BoxFit.cover,
                    height: height,
                    width: width,
                  )
                : Image.asset(
                    Assets.bgPlaceholderImage,
                    fit: BoxFit.cover,
                    height: height,
                    width: width,
                  ),
      ),
    );
  }
}
