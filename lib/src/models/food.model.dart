import "package:food_delivery_app/src/models/model.dart";

class Food {
  Food({
    required this.customizedFood,
    required this.description,
    required this.image,
    required this.name,
    required this.price,
    required this.id,
  });

  final List<CustomizedFood> customizedFood;
  final String? description;
  final String? image;
  final String? name;
  final double? price;
  final String? id;

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      customizedFood: json["customized_food"] == null
          ? []
          : List<CustomizedFood>.from(
              json["customized_food"]!.map((x) => CustomizedFood.fromJson(x))),
      description: json["description"],
      image: json["image"],
      name: json["name"],
      price: json["price"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "customized_food": customizedFood.map((x) => x.toJson()).toList(),
        "description": description,
        "image": image,
        "name": name,
        "price": price,
        "id": id,
      };

  @override
  String toString() {
    return "$customizedFood, $description, $image, $name, $price, $id, ";
  }
}
