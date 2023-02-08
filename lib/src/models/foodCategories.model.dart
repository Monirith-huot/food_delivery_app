import 'food.model.dart';

class FoodCategory {
  final String cId;
  final String cName;
  final List<Food> cFood;

  FoodCategory({required this.cId, required this.cName, required this.cFood});
}
