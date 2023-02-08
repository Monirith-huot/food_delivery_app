import 'foodCategories.model.dart';

class Restaurant {
  final String rId;
  final String rImage;
  final String rDiscount;
  final String rName;
  final String rLocation;
  final String rating;
  final List<FoodCategory> categories;

  Restaurant({
    required this.rId,
    required this.rImage,
    required this.rDiscount,
    required this.rName,
    required this.rLocation,
    required this.rating,
    required this.categories,
  });
}
