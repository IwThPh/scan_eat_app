import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';

abstract class ScanningRepository {
  Future<Either<Failure, Product>> getProduct(String barcode);
}