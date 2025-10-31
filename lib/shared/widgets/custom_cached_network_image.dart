import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_assets.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String? profileUrl;
  final double width;
  final double height;
  final String? errorImage;
  final String? placeHolderImage;
  final bool isProfile;

  const CustomCachedNetworkImage({
    super.key,
    required this.profileUrl,
    required this.width,
    required this.height,
    this.errorImage,
    this.placeHolderImage,
    required this.isProfile,
  });

  @override
  Widget build(BuildContext context) {
    return profileUrl != null
        ? CachedNetworkImage(
            imageUrl: profileUrl!,
            width: width,
            height: height,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return Image.asset(
                placeHolderImage ??
                    (isProfile
                        ? AppAssets.profilePlaceHolderImage
                        : AppAssets.placeHolderImage),
                width: width,
                height: height,
                fit: BoxFit.cover,
              );
            },
            errorWidget: (context, url, error) {
              return Image.asset(
                errorImage ??
                    (isProfile
                        ? AppAssets.profileErrorImage
                        : AppAssets.errorImage),
                width: height,
                height: height,
                fit: BoxFit.cover,
              );
            },
          )
        : Image.asset(
            errorImage ??
                (isProfile
                    ? AppAssets.profileErrorImage
                    : AppAssets.errorImage),
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
  }
}
