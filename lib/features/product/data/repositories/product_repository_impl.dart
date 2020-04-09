import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/device/network_info.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../login/data/datasources/login_local_data_source.dart';
import '../../../login/data/models/auth_model.dart';
import '../../../product/domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository{
  final ProductRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Product>> saveProduct(String barcode) async {
    networkInfo.isConnected;
    try {
      AuthModel auth = await localDataSource.getAuth();
      final remoteProduct = await remoteDataSource.saveProduct(barcode, auth.accessToken);
      return Right(remoteProduct);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> unsaveProduct(String barcode) async {
    networkInfo.isConnected;
    try {
      AuthModel auth = await localDataSource.getAuth();
      final remoteProduct = await remoteDataSource.unsaveProduct(barcode, auth.accessToken);
      return Right(remoteProduct);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}