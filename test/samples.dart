import 'package:food_label_app/features/scanning/data/models/product_model.dart';
import 'package:food_label_app/features/scanning/domain/entities/product.dart';

class Samples {
  static final Product tProduct = Product(
      barcode: '0737628064502',
      name: 'Stir-Fry Rice Noodles',
      carbohydrate_100g: 70.5,
      energy_100g: 1660.0,
      fat_100g: 8.97,
      fiber_100g: 0.0,
      protein_100g: 8.97,
      salt_100g: 2.05,
      saturates_100g: 1.28,
      sodium_100g: 0.82,
      sugars_100g: 12.8,
      weight_g: 155.0);

  static final ProductModel tProductModel = ProductModel(
      barcode: tProduct.barcode,
      name: tProduct.name,
      carbohydrate_100g: tProduct.carbohydrate_100g,
      energy_100g: tProduct.energy_100g,
      fat_100g: tProduct.fat_100g,
      fiber_100g: tProduct.fiber_100g,
      protein_100g: tProduct.protein_100g,
      salt_100g: tProduct.salt_100g,
      saturates_100g: tProduct.saturates_100g,
      sodium_100g: tProduct.sodium_100g,
      sugars_100g: tProduct.sugars_100g,
      weight_g: tProduct.weight_g);

  static final String tProductJson =
      "{\"id\":105,\"barcode\":\"0737628064502\",\"name\":\"Stir-Fry Rice Noodles\",\"weight_g\":155,\"energy_100g\":1660,\"carbohydrate_100g\":70.5,\"protein_100g\":8.97,\"fat_100g\":8.97,\"fiber_100g\":0,\"salt_100g\":2.05,\"sugar_100g\":12.8,\"saturated_100g\":1.28,\"sodium_100g\":0.819,\"created_at\":\"2019-11-10T18:22:51.000000Z\",\"updated_at\":\"2019-11-10T18:22:51.000000Z\"}";
}
