import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/widgets/loading/shimmer/shimmer_container.dart';
import '../models/recipes_model.dart';

class RecipeListItem extends StatelessWidget {
  final RecipeModel recipe;
  final VoidCallback? onTap;

  const RecipeListItem({
    super.key,
    required this.recipe,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: HSizes.buttonElevation4,
      shadowColor: HColors.primary.withValues(alpha: 0.3),
      margin: const EdgeInsets.symmetric(
        vertical: HSizes.sm8,
        horizontal: HSizes.md16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(HSizes.cardRadiusMd12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(HSizes.cardRadiusMd12),
        child: Padding(
          padding: const EdgeInsets.all(HSizes.buttonPadding12),
          child: Row(
            children: [
              // Recipe Image
              ClipRRect(
                borderRadius: BorderRadius.circular(HSizes.cardRadiusMd12),
                child: CachedNetworkImage(
                  imageUrl: recipe.image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const ShimmerContainer.rectangular(
                    width: 100,
                    height: 100,
                    borderRadius: BorderRadius.all(Radius.circular(HSizes.cardRadiusMd12)),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: HColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(HSizes.cardRadiusMd12),
                    ),
                    child: Icon(Icons.restaurant, color: HColors.primary),
                  ),
                ),
              ),
              const SizedBox(width: HSizes.buttonPadding12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      recipe.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: HSizes.sm8),
                    Row(
                      children: [
                        Icon(Icons.timer_outlined, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${recipe.prepTimeMinutes + recipe.cookTimeMinutes} mins',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                        const SizedBox(width: HSizes.md16),
                        Icon(Icons.people_outline, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${recipe.servings} servings',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: HSizes.sm8),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber[700]),
                        const SizedBox(width: 4),
                        Text(
                          recipe.rating.toString(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                        const SizedBox(width: HSizes.md16),
                        Icon(Icons.restaurant_menu, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          recipe.cuisine,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                    if (recipe.tags != null && recipe.tags!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: HSizes.sm8),
                        child: Wrap(
                          spacing: HSizes.xs4,
                          runSpacing: HSizes.xxs2,
                          children: recipe.tags!
                              .map((tag) => Chip(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    label: Text(
                                      tag,
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 10),
                                    ),
                                    padding: const EdgeInsets.all(0),
                                    visualDensity: VisualDensity.compact,
                                    backgroundColor: HColors.primary.withValues(alpha: 0.5),
                                  ))
                              .toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
