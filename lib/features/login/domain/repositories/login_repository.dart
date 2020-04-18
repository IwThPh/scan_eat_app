
import 'package:dartz/dartz.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/features/login/domain/entities/auth.dart';
import 'package:scaneat/features/login/domain/entities/user.dart';
import 'package:scaneat/features/login/domain/entities/validator.dart';

abstract class LoginRepository {
  Future<Either<Failure, Auth>> attemptLogin(String email, String password);
  Future<Either<Failure, Either<Validator, Auth>>> attemptRegister(String name, String email, String password, String cPassword);
  Future<Either<Failure, bool>> cacheAuth(Auth auth);
  Future<Either<Failure, Auth>> getAuth();
  Future<Either<Failure, User>> getUser();
}