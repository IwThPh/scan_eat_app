class Item {
  String barcode;
  ItemDetails details;

  Item({this.barcode, this.details});

  factory Item.fromJson(Map<String, dynamic> json) {
    final _map = json['product'];
    return Item(barcode: json['code'], details: ItemDetails.fromJson(_map));
  }
}

class ItemDetails {
  String name;
  double weight;
  String imagePath;
  ItemNutriments nutriments;

  ItemDetails({this.name, this.weight, this.imagePath, this.nutriments});

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    final _map = json['nutriments'];
    return ItemDetails(
        name: json['product_name'],
        weight: json['product_quantity'],
        imagePath: json['image_front_small_url'],
        nutriments: ItemNutriments.fromJson(_map));
  }
}

class ItemNutriments {
  double energy_100g;
  double fat_100g;
  double saturates_100g;
  double sugars_100g;
  double salt_100g;

  ItemNutriments(
      {this.energy_100g,
      this.fat_100g,
      this.saturates_100g,
      this.sugars_100g,
      this.salt_100g});

  //TODO: Macro Nutrients could be added here.
  factory ItemNutriments.fromJson(Map<String, dynamic> json) {
    return ItemNutriments(
        energy_100g: json['energy_100g'],
        fat_100g: json['fat_100g'],
        saturates_100g: json['saturated-fat_100g'],
        sugars_100g: json['sugars_100g'],
        salt_100g: json['salt_100g']);
  }
}
