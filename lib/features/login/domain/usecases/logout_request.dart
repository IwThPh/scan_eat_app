import 'package:dartz/dartz.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/login/domain/repositories/login_repository.dart';

class LogoutRequest implements UseCase<bool, NoParams> {
  final LoginRepository repo;

  LogoutRequest(this.repo);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repo.attemptLogout();
  }
}
