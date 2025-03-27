import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'shimmer_container.dart';

class ShimmerListItem extends StatelessWidget {
  final double? height;
  final EdgeInsetsGeometry? margin;

  const ShimmerListItem({
    super.key,
    this.height = 90,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: HSizes.buttonElevation4,
      shadowColor: HColors.primary.withValues(alpha: 0.3),
      margin: margin ??
          const EdgeInsets.symmetric(
            vertical: HSizes.sm8,
            horizontal: HSizes.md16,
          ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(HSizes.cardRadiusMd12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(HSizes.buttonPadding12),
        child: Row(
          children: [
            // Recipe Image
            const ShimmerContainer.rectangular(
              width: 100,
              height: 100,
              borderRadius: BorderRadius.all(Radius.circular(HSizes.cardRadiusMd12)),
            ),
            const SizedBox(width: HSizes.buttonPadding12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Recipe Name
                  ShimmerContainer.rectangular(
                    height: 20,
                    width: 200,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  SizedBox(height: HSizes.sm8),
                  // Time and Servings
                  Row(
                    children: [
                      ShimmerContainer.rectangular(
                        height: 16,
                        width: 80,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      SizedBox(width: HSizes.md16),
                      ShimmerContainer.rectangular(
                        height: 16,
                        width: 80,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ],
                  ),
                  SizedBox(height: HSizes.sm8),
                  // Rating and Cuisine
                  Row(
                    children: [
                      ShimmerContainer.rectangular(
                        height: 16,
                        width: 60,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      SizedBox(width: HSizes.md16),
                      ShimmerContainer.rectangular(
                        height: 16,
                        width: 80,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ],
                  ),
                  // Tags
                  Wrap(
                    spacing: HSizes.xs4,
                    runSpacing: HSizes.xxs2,
                    children: List.generate(
                      3,
                      (index) => ShimmerContainer.rectangular(
                        height: 16,
                        width: 80,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
