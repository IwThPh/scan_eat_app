import 'package:dartz/dartz.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/login/domain/entities/user.dart';
import 'package:scaneat/features/login/domain/repositories/login_repository.dart';

class RetrieveUser implements UseCase<User, NoParams> {
  final LoginRepository repo;

  RetrieveUser(this.repo);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repo.getUser();
  }
}
