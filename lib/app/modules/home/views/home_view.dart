import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webleger_task/app/data/services/auth/auth_service.dart';

import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/constants/text_strings.dart';
import '../../../../core/widgets/appbar/custom_appbar.dart';
import '../../../../core/widgets/avatar/profile_avatar.dart';
import '../../../../core/widgets/error/empty_widget.dart';
import '../../../../core/widgets/loading/shimmer/shimmer_list_view.dart';
import '../../../../core/widgets/searchbar/searchbar.dart';
import '../controllers/home_controller.dart';
import '../widgets/recipe_list_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: CustomAppBar.withText(
        title: HTexts.home,
        showBackButton: false,
        leadingWidget: Padding(
          padding: const EdgeInsets.all(HSizes.sm8),
          child: ProfileAvatar(
            imageUrl: AuthService.to.currentUser?.image,
            onTap: () {},
          ),
        ),
        actions: [
          IconButton(onPressed: controller.logout, icon: const Icon(Icons.logout), tooltip: 'Logout'),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.getRecipes,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const ShimmerListView();
          }

          if (controller.recipes.isEmpty) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - kToolbarHeight,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.restaurant_menu,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No recipes found',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Pull down to refresh',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: HSearchBar(
                  searchController: controller.searchController,
                  hintText: 'Search recipes...',
                ),
              ),
              Expanded(
                child: controller.filteredRecipes.isEmpty && controller.searchController.text.isNotEmpty
                    ? EmptyWidget(message: 'No results found for "${controller.searchController.text}"')
                    : ListView.builder(
                        itemCount: controller.filteredRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = controller.filteredRecipes[index];
                          return RecipeListItem(
                            recipe: recipe,
                            onTap: () {},
                          );
                        },
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
