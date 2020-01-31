import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:scaneat/core/device/network_info.dart';
import 'package:scaneat/core/error/exception.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/features/login/data/datasources/login_remote_data_source.dart';
import 'package:scaneat/features/login/domain/entities/auth.dart';
import 'package:scaneat/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Auth>> attemptLogin(
      String email, String password) async {
    networkInfo.isConnected;
    try {
      return Right(await remoteDataSource.attemptLogin(email, password));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
