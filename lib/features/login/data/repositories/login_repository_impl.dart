import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:scaneat/core/device/network_info.dart';
import 'package:scaneat/core/error/exception.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/features/login/data/datasources/login_local_data_source.dart';
import 'package:scaneat/features/login/data/datasources/login_remote_data_source.dart';
import 'package:scaneat/features/login/domain/entities/auth.dart';
import 'package:scaneat/features/login/domain/entities/validator.dart';
import 'package:scaneat/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Auth>> attemptLogin(
      String email, String password) async {
    networkInfo.isConnected;
    try {
      Auth auth = await remoteDataSource.attemptLogin(email, password);
      localDataSource.cacheAuth(auth);
      return Right(auth);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Either<Validator, Auth>>> attemptRegister(
      String name, String email, String password, String c_password) async {
    networkInfo.isConnected;
    try {
      Either<Validator, Auth> eitherValidatorOrAuth = await remoteDataSource
          .attemptRegister(name, email, password, c_password);
      return eitherValidatorOrAuth.fold(
        (validator) => Right(Left(validator)),
        (auth) {
          localDataSource.cacheAuth(auth);
          return Right(Right(auth));
        },
      );
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> cacheAuth(Auth auth) async {
    try {
      return Right(await localDataSource.cacheAuth(auth));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
