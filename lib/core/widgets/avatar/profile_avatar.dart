import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../loading/shimmer/shimmer_container.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final double imageSize;
  final VoidCallback? onTap;
  final IconData errorIcon;
  final double errorIconSize;
  final Color errorIconColor;
  final bool showShadow;

  const ProfileAvatar({
    super.key,
    this.imageUrl,
    this.radius = 20,
    this.imageSize = 30,
    this.onTap,
    this.errorIcon = Icons.person,
    this.errorIconSize = 30,
    this.errorIconColor = HColors.primary,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: HColors.white,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl ?? '',
            width: imageSize,
            height: imageSize,
            fit: BoxFit.cover,
            placeholder: (context, url) => ShimmerContainer.circular(size: imageSize),
            errorWidget: (context, url, error) => Icon(
              errorIcon,
              size: errorIconSize,
              color: errorIconColor,
            ),
          ),
        ),
      ),
    );
  }
}
