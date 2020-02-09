
import 'package:dartz/dartz.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/features/login/domain/entities/auth.dart';

abstract class LoginRepository {
  Future<Either<Failure, Auth>> attemptLogin(String email, String password);
  Future<Either<Failure, bool>> cacheAuth(Auth auth);
}