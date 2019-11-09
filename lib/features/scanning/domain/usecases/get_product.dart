import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:food_label_app/core/error/failure.dart';
import 'package:food_label_app/features/scanning/domain/entities/product.dart';
import 'package:food_label_app/features/scanning/domain/repositories/scanning_repository.dart';

class GetProduct {
  final ScanningRepository repo;

  GetProduct(this.repo);

  Future<Either<Failure,Product>> execute({
    @required String barcode,
  }) async {
    return await repo.getProduct(barcode);
  }
}