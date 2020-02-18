
import 'package:dartz/dartz.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/entities/diet.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';

class GetDiet implements UseCase<List<Diet>, NoParams> {
  final HomeRepository repo;

  GetDiet(this.repo);

  @override
  Future<Either<Failure, List<Diet>>> call(NoParams params) async {
    return await repo.getDiets();
  }
}