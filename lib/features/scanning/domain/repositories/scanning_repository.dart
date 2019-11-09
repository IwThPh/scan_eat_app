import 'package:dartz/dartz.dart';
import 'package:food_label_app/core/error/failure.dart';
import 'package:food_label_app/features/scanning/domain/entities/product.dart';

abstract class ScanningRepository {
  Future<Either<Failure, Product>> getProduct(String barcode);
}