import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/device/network_info.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/scanning_repository.dart';
import '../datasources/scanning_remote_data_source.dart';

class ScanningRepositoryImpl implements ScanningRepository{
  final ScanningRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ScanningRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Product>> getProduct(String barcode) async {
    networkInfo.isConnected;
    try {
      final remoteProduct = await remoteDataSource.getProduct(barcode);
      return Right(remoteProduct);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}