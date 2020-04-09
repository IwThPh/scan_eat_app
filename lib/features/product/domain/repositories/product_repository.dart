import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> saveProduct(String barcode);
  Future<Either<Failure, Product>> unsaveProduct(String barcode);
}
