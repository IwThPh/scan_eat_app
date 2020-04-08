import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/device/network_info.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../login/data/datasources/login_local_data_source.dart';
import '../../../login/data/models/auth_model.dart';
import '../../../product/domain/entities/product.dart';
import '../../domain/repositories/scanning_repository.dart';
import '../datasources/scanning_remote_data_source.dart';

class ScanningRepositoryImpl implements ScanningRepository{
  final ScanningRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ScanningRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Product>> getProduct(String barcode) async {
    networkInfo.isConnected;
    try {
      AuthModel auth = await localDataSource.getAuth();
      final remoteProduct = await remoteDataSource.getProduct(barcode, auth.accessToken);
      return Right(remoteProduct);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}