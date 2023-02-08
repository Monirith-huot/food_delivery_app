class Food {
  final String fid;
  final String fTitle;
  final String fDescription;
  final double fPrice;
  final String fImage;
  final List<Food> fCustomizeFood;

  Food({
    required this.fid,
    required this.fTitle,
    required this.fDescription,
    required this.fPrice,
    required this.fImage,
    required this.fCustomizeFood,
  });
}
