import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

import '../../../../core/utils/helpers/logger.dart';
import '../../../data/models/response_model.dart';
import '../../../data/providers/network_db/api_endpoint.dart';
import '../../../data/providers/network_db/api_provider.dart';
import '../models/recipes_model.dart';

class HomeRepository {
  final ApiProvider _apiService = Get.find<ApiProvider>();

  Future<ResponseModel<List<RecipeModel>>> getRecipes() async {
    final ResponseModel response = await _apiService.get(ApiEndpoints.recipes);

    if (response.success && response.data != null) {
      final List<dynamic> recipesData = response.data!['recipes'] ?? [];
      final List<RecipeModel> recipes = recipesData.map((json) => RecipeModel.fromJson(json)).toList();

      return ResponseModel.success(recipes, response.data!['message'] ?? 'Recipes fetched successfully');
    }

    HLoggerHelper.error("Failed to fetch recipes: ${response.message ?? 'Unknown error'}");
    return ResponseModel.error(response.message ?? 'Failed to fetch recipes');
  }
}
