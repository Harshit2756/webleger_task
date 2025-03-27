import 'package:json_annotation/json_annotation.dart';

part 'recipes_model.g.dart';

@JsonSerializable()
class RecipeModel {
  RecipeModel({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.tags,
    required this.userId,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.mealType,
  });

  final int id;
  final String name;
  final List<String>? ingredients;
  final List<String>? instructions;
  final num prepTimeMinutes;
  final num cookTimeMinutes;
  final num servings;
  final String difficulty;
  final String cuisine;
  final num caloriesPerServing;
  final List<String>? tags;
  final num userId;
  final String image;
  final num rating;
  final num reviewCount;
  final List<String>? mealType;

  factory RecipeModel.fromJson(Map<String, dynamic> json) => _$RecipeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);

  @override
  String toString() {
    return "$id, $name, $ingredients, $instructions, $prepTimeMinutes, $cookTimeMinutes, $servings, $difficulty, $cuisine, $caloriesPerServing, $tags, $userId, $image, $rating, $reviewCount, $mealType, ";
  }
}

/*
{
	"id": 1,
	"name": "Classic Margherita Pizza",
	"ingredients": [
		"Pizza dough",
		"Tomato sauce",
		"Fresh mozzarella cheese",
		"Fresh basil leaves",
		"Olive oil",
		"Salt and pepper to taste"
	],
	"instructions": [
		"Preheat the oven to 475°F (245°C).",
		"Roll out the pizza dough and spread tomato sauce evenly.",
		"Top with slices of fresh mozzarella and fresh basil leaves.",
		"Drizzle with olive oil and season with salt and pepper.",
		"Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.",
		"Slice and serve hot."
	],
	"prepTimeMinutes": 20,
	"cookTimeMinutes": 15,
	"servings": 4,
	"difficulty": "Easy",
	"cuisine": "Italian",
	"caloriesPerServing": 300,
	"tags": [
		"Pizza",
		"Italian"
	],
	"userId": 166,
	"image": "https://cdn.dummyjson.com/recipe-images/1.webp",
	"rating": 4.6,
	"reviewCount": 98,
	"mealType": [
		"Dinner"
	]
}*/
