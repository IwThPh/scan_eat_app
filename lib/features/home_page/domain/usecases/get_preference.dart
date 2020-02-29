import 'package:dartz/dartz.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/entities/preference.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';

class GetPreference implements UseCase<Preference, NoParams> {
  final HomeRepository repo;

  GetPreference(this.repo);

  @override
  Future<Either<Failure, Preference>> call(NoParams params) async {
    return await repo.getPreference();
  }
}