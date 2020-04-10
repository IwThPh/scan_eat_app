import 'package:dartz/dartz.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';
import 'package:scaneat/features/product/domain/entities/product.dart';

class GetSaved implements UseCase<List<Product>, NoParams> {
  GetSaved(this.repo);

  final HomeRepository repo;

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repo.getSaved();
  }
}