import "package:food_delivery_app/src/models/model.dart";

class Restaurant {
  Restaurant({
    required this.categories,
    required this.discount,
    required this.fee,
    required this.foodCategories,
    required this.image,
    required this.isFavorite,
    required this.location,
    required this.name,
    required this.rId,
    required this.rating,
  });

  final List<String> categories;
  final String? discount;
  final String? fee;
  final List<FoodCategory> foodCategories;
  final String? image;
  final bool? isFavorite;
  final String? location;
  final String? name;
  final String? rId;
  final String? rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      categories: json["categories"] == null
          ? []
          : List<String>.from(json["categories"]!.map((x) => x)),
      discount: json["discount"],
      fee: json["fee"],
      foodCategories: json["food_categories"] == null
          ? []
          : json["food_categories"]!.map((x) => FoodCategory.fromJson(x)),
      image: json["image"],
      isFavorite: json["isFavorite"],
      location: json["location"],
      name: json["name"],
      rId: json["rId"],
      rating: json["rating"],
    );
  }

  Map<String, dynamic> toJson() => {
        "categories": categories.map((x) => x).toList(),
        "discount": discount,
        "fee": fee,
        "food_categories": foodCategories.map((x) => x.toJson()).toList(),
        "image": image,
        "isFavorite": isFavorite,
        "location": location,
        "name": name,
        "rId": rId,
        "rating": rating,
      };

  @override
  String toString() {
    return "$categories, $discount, $fee, $foodCategories, $image, $isFavorite, $location, $name, $rId, $rating, ";
  }
}
