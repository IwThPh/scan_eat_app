import 'package:dartz/dartz.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/entities/allergen.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';

class GetAllergen implements UseCase<List<Allergen>, NoParams> {
  final HomeRepository repo;

  GetAllergen(this.repo);

  @override
  Future<Either<Failure, List<Allergen>>> call(NoParams params) async {
    return await repo.getAllergens();
  }
}