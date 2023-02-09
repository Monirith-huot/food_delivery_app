class CustomizedFood {
  CustomizedFood({
    required this.size,
    required this.price,
  });

  final String? size;
  final double? price;

  factory CustomizedFood.fromJson(Map<String, dynamic> json) {
    return CustomizedFood(
      size: json["size"],
      price: json["price"],
    );
  }

  Map<String, dynamic> toJson() => {
        "size": size,
        "price": price,
      };

  @override
  String toString() {
    return "$size, $price, ";
  }
}
