import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/helpers/logger.dart';
import '../../../data/services/auth/auth_service.dart';
import '../models/recipes_model.dart';
import '../repositories/home_repository.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  /// Variables
  final isLoading = false.obs;
  final recipes = <RecipeModel>[].obs;
  final filteredRecipes = <RecipeModel>[].obs;
  final error = RxnString();
  final searchController = SearchController();
  final _repository = Get.put(HomeRepository());

  @override
  void onInit() {
    super.onInit();
    getRecipes();
    searchController.addListener(_filterRecipes);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void _filterRecipes() {
    if (searchController.text.isEmpty) {
      filteredRecipes.value = recipes;
      return;
    }

    final query = searchController.text.toLowerCase();
    filteredRecipes.value = recipes.where((recipe) {
      return recipe.name.toLowerCase().contains(query) ||
          recipe.cuisine.toLowerCase().contains(query) ||
          (recipe.tags?.any((tag) => tag.toLowerCase().contains(query)) ?? false);
    }).toList();
  }

  Future<void> getRecipes() async {
    try {
      isLoading.value = true;
      error.value = null;
      final response = await _repository.getRecipes();

      if (response.success) {
        recipes.value = response.data ?? [];
        _filterRecipes();
        if (recipes.isEmpty) {
          error.value = 'No recipes found';
        }
      } else {
        error.value = response.message ?? 'Failed to fetch recipes';
      }
    } catch (e) {
      HLoggerHelper.error("Failed to fetch recipes: $e");
      error.value = 'Something went wrong. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    AuthService.to.logout();
  }
}
