class Product {
  String barcode;
  String name;
  double weight_g;
  double energy_100g;
  double carbohydrate_100g;
  double protein_100g;
  double fat_100g;
  double fiber_100g;
  double salt_100g;
  double sugars_100g;
  double saturates_100g;
  double sodium_100g;

  Product(
      {this.barcode,
      this.name,
      this.weight_g,
      this.energy_100g,
      this.carbohydrate_100g,
      this.protein_100g,
      this.fat_100g,
      this.fiber_100g,
      this.salt_100g,
      this.sugars_100g,
      this.saturates_100g,
      this.sodium_100g});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      barcode: json['barcode'],
      name: json['name'],
      weight_g: json['weight_g']?.toDouble(),
      energy_100g: json['energy_100g']?.toDouble(),
      carbohydrate_100g: json['carbohydrate_100g']?.toDouble(),
      protein_100g: json['protein_100g']?.toDouble(),
      fat_100g: json['fat_100g']?.toDouble(),
      fiber_100g: json['fiber_100g']?.toDouble(),
      salt_100g: json['salt_100g']?.toDouble(),
      sugars_100g: json['sugars_100g']?.toDouble(),
      saturates_100g: json['saturated_100g']?.toDouble(),
      sodium_100g: json['sodium_100g']?.toDouble(),
    );
  }
}
