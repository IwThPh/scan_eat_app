import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:scaneat/core/device/network_info.dart';
import 'package:scaneat/core/error/exception.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/features/home_page/data/datasources/home_remote_data_source.dart';
import 'package:scaneat/features/home_page/domain/entities/allergen.dart';
import 'package:scaneat/features/home_page/domain/entities/diet.dart';
import 'package:scaneat/features/home_page/domain/entities/preference.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';
import 'package:scaneat/features/login/data/datasources/login_local_data_source.dart';
import 'package:scaneat/features/login/data/models/auth_model.dart';
import 'package:scaneat/features/product/domain/entities/product.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  /// Attempts to retrive Allergens from [HomeRemoteDataSource].
  /// 
  /// On Success, List of [Allergen].
  /// On Failure, [ServerFailure].
  @override
  Future<Either<Failure, List<Allergen>>> getAllergens() async {
    networkInfo.isConnected;
    try {
      AuthModel auth = await localDataSource.getAuth();
      List<Allergen> allergens = await remoteDataSource.getAllergens(auth.accessToken);
      return Right(allergens);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /// Attempts to retrive Diets from [HomeRemoteDataSource].
  /// 
  /// On Success, List of [Diet].
  /// On Failure, [ServerFailure].
  @override
  Future<Either<Failure, List<Diet>>> getDiets() async {
    networkInfo.isConnected;
    try {
      AuthModel auth = await localDataSource.getAuth();
      List<Diet> diets = await remoteDataSource.getDiets(auth.accessToken);
      return Right(diets);
    } on ServerException {
      return Left(ServerFailure()); }
  }

  /// Attempts to select Allergens using [HomeRemoteDataSource].
  /// 
  /// [allergens], List of allergen ids to select.
  /// 
  /// On Success, [String] message.
  /// On Failure, [ServerFailure].
  @override
  Future<Either<Failure, String>> selectAllergens(List<Allergen> allergens) async {
    networkInfo.isConnected;
    try {
      List<int> selected = allergens.where((a) => a.selected).map((a)=> a.id).toList();
      AuthModel auth = await localDataSource.getAuth();
      String result = await remoteDataSource.selectAllergens(auth.accessToken, selected);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /// Attempts to select Diets using [HomeRemoteDataSource].
  /// 
  /// [diets], List of diet ids to select.
  /// 
  /// On Success, [String] message.
  /// On Failure, [ServerFailure].
  @override
  Future<Either<Failure, String>> selectDiets(List<Diet> diets) async {
    networkInfo.isConnected;
    try {
      List<int> selected = diets.where((d) => d.selected).map((d)=> d.id).toList();
      AuthModel auth = await localDataSource.getAuth();
      String result = await remoteDataSource.selectDiets(auth.accessToken, selected);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /// Attempts to delete user Preference using [HomeRemoteDataSource].
  /// 
  /// On Success, [Preference].
  /// On Failure, [ServerFailure].
  @override
  Future<Either<Failure, Preference>> deletePreference() async {
    networkInfo.isConnected;
    try {
      AuthModel auth = await localDataSource.getAuth();
      Preference pref = await remoteDataSource.deletePreference(auth.accessToken);
      return Right(pref);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /// Attempts to retrieve user Preference using [HomeRemoteDataSource].
  /// 
  /// On Success, [Preference].
  /// On Failure, [ServerFailure].
  @override
  Future<Either<Failure, Preference>> getPreference() async {
    networkInfo.isConnected;
    try {
      AuthModel auth = await localDataSource.getAuth();
      Preference pref = await remoteDataSource.getPreference(auth.accessToken);
      return Right(pref);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /// Attempts to update user Preference using [HomeRemoteDataSource].
  /// 
  /// [preference], the updated values to be sent.
  /// 
  /// On Success, [Preference].
  /// On Failure, [ServerFailure].
  @override
  Future<Either<Failure, Preference>> updatePreference(preference) async {
    networkInfo.isConnected;
    try {
      AuthModel auth = await localDataSource.getAuth();
      Preference pref = await remoteDataSource.updatePreference(auth.accessToken, preference);
      return Right(pref);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /// Attempts to retrieve user scan history using [HomeRemoteDataSource].
  /// 
  /// On Success, list of [Product].
  /// On Failure, [ServerFailure].
  @override
  Future<Either<Failure, List<Product>>> getHistory() async {
    networkInfo.isConnected;
    try {
      AuthModel auth = await localDataSource.getAuth();
      List<Product> products = await remoteDataSource.getHistory(auth.accessToken);
      return Right(products);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /// Attempts to retrieve user saved products using [HomeRemoteDataSource].
  /// 
  /// On Success, list of [Product].
  /// On Failure, [ServerFailure].
  @override
  Future<Either<Failure, List<Product>>> getSaved() async {
    networkInfo.isConnected;
    try {
      AuthModel auth = await localDataSource.getAuth();
      List<Product> products = await remoteDataSource.getSaved(auth.accessToken);
      return Right(products);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
