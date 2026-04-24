enum FoodQuantityUnit {
  grams('g'),
  milliliters('ml'),
  serving('serving'),
  slice('slice'),
  unit('unit');

  const FoodQuantityUnit(this.symbol);

  final String symbol;
}
