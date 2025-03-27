import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../../utils/constants/icons_strings.dart';
import '../../utils/constants/sizes.dart';

class HSearchBar extends StatelessWidget {
  final SearchController searchController;
  final String hintText;
  final Widget? trailing;

  const HSearchBar({
    super.key,
    required this.searchController,
    this.hintText = 'Search',
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      backgroundColor: const WidgetStatePropertyAll(HColors.white),
      elevation: const WidgetStatePropertyAll(0.0),
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(HSizes.buttonRadius30)),
        ),
      ),
      side: WidgetStatePropertyAll(
        BorderSide(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
      ),
      controller: searchController,
      hintText: hintText,
      leading: const Padding(padding: EdgeInsets.all(HSizes.sm8), child: Icon(HIcons.search, color: Colors.black, size: HSizes.lg24)),
      trailing: [
        IconButton(
          onPressed: () => searchController.clear(),
          icon: const Icon(HIcons.close, color: Colors.black, size: HSizes.lg24),
        ),
        trailing ?? const SizedBox(),
      ],
    );
  }
}
