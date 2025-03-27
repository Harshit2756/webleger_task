import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import 'shimmer_container.dart';
import 'shimmer_list_item.dart';

class ShimmerListView extends StatelessWidget {
  const ShimmerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar Shimmer
        Padding(
          padding: const EdgeInsets.all(HSizes.md16),
          child: const ShimmerContainer.rectangular(
            width: double.infinity,
            height: HSizes.appBarHeight56,
            borderRadius: BorderRadius.all(Radius.circular(HSizes.buttonRadius30)),
          ),
        ),
        // List Items Shimmer
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(top: 16),
            children: List.generate(
              10,
              (index) => const ShimmerListItem(),
            ),
          ),
        ),
      ],
    );
  }
}
