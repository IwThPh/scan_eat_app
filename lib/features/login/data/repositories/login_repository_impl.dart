import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:scaneat/core/device/network_info.dart';
import 'package:scaneat/core/error/exception.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/features/login/data/datasources/login_local_data_source.dart';
import 'package:scaneat/features/login/data/datasources/login_remote_data_source.dart';
import 'package:scaneat/features/login/data/models/auth_model.dart';
import 'package:scaneat/features/login/data/models/validator_model.dart';
import 'package:scaneat/features/login/domain/entities/auth.dart';
import 'package:scaneat/features/login/domain/entities/user.dart';
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

  /// Attempts to Login using [LoginRemoteDataSource].
  /// 
  /// [email] and [password] User credentials.
  /// 
  /// On Success, [Auth].
  /// On Failure, [ServerFailure].
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

  /// Attempts to Loggout using [LoginRemoteDataSource].
  /// 
  /// On Success, [bool].
  /// On Failure, [ServerFailure].
  @override
  Future<Either<Failure, bool>> attemptLogout() async {
    try {
      var result = await localDataSource.removeAuth();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /// Attempts to register using [LoginRemoteDataSource].
  /// 
  /// [name], [email], and [password] to register.
  /// 
  /// On Successful server response, [Auth].
  /// On Unseccessful server response, [Validator].
  /// On Failure, [ServerFailure].
  @override
  Future<Either<Failure, Either<Validator, Auth>>> attemptRegister(
      String name, String email, String password, String cPassword) async {
    networkInfo.isConnected;
    try {
      Either<ValidatorModel, AuthModel> eitherValidatorOrAuth =
          await remoteDataSource.attemptRegister(
              name, email, password, cPassword);
      return eitherValidatorOrAuth.fold(
        (validator) {
          return Right(Left(validator));
        },
        (auth) {
          localDataSource.cacheAuth(auth);
          return Right(Right(auth));
        },
      );
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /// Attempts to cache auth details using [LoginLocalDataSource].
  /// 
  /// [auth], to cache.
  /// 
  /// On Successful, [bool] response from local data source.
  /// On Failure, [CacheFailure].
  @override
  Future<Either<Failure, bool>> cacheAuth(Auth auth) async {
    try {
      return Right(await localDataSource.cacheAuth(auth));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  /// Attempts to retrieve cached auth details from [LoginLocalDataSource].
  /// 
  /// On Successful, [bool] response from local data source.
  /// On Failure, [CacheFailure].
  @override
  Future<Either<Failure, Auth>> getAuth() async {
    try {
      return Right(await localDataSource.getAuth());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  /// Attempts to retrieve user details from [LoginRemoteDataSource].
  /// 
  /// On Successful, [User] response from remote data source.
  /// On Failure, [ServerFailure].
  @override
  Future<Either<Failure, User>> getUser() async {
    networkInfo.isConnected;
    try {
      AuthModel auth = await localDataSource.getAuth();
      String token = auth.accessToken;
      User user = await remoteDataSource.retrieveUser(token);
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
