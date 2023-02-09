import "package:food_delivery_app/src/models/model.dart";

class FoodCategory {
  FoodCategory({
    required this.name,
    required this.food,
  });

  final String? name;
  final Food? food;

  factory FoodCategory.fromJson(Map<String, dynamic> json) {
    return FoodCategory(
      name: json["name"],
      food: json["food"] == null ? null : Food.fromJson(json["food"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "food": food?.toJson(),
      };

  @override
  String toString() {
    return "$name, $food, ";
  }
}
