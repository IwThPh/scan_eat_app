import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:http/http.dart' as http;
import 'package:scaneat/core/device/network_info.dart';
import 'package:scaneat/features/home_page/data/datasources/home_remote_data_source.dart';
import 'package:scaneat/features/home_page/data/repositories/home_repository_impl.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_allergen.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_diet.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/bloc.dart';
import 'package:scaneat/features/login/data/datasources/login_local_data_source.dart';
import 'package:scaneat/features/login/data/datasources/login_remote_data_source.dart';
import 'package:scaneat/features/login/data/repositories/login_repository_impl.dart';
import 'package:scaneat/features/login/domain/repositories/login_repository.dart';
import 'package:scaneat/features/login/domain/usecases/login_request.dart';
import 'package:scaneat/features/login/domain/usecases/register_request.dart';
import 'package:scaneat/features/login/presentation/bloc/login_page_bloc.dart';
import 'package:scaneat/features/scanning/data/datasources/scanning_remote_data_source.dart';
import 'package:scaneat/features/scanning/data/repositories/scanning_repository_impl.dart';
import 'package:scaneat/features/scanning/domain/repositories/scanning_repository.dart';
import 'package:scaneat/features/scanning/domain/usecases/get_product.dart';
import 'package:scaneat/features/scanning/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:scaneat/features/scanning/presentation/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // | Features |
  // Bloc
  sl.registerFactory(() => ScanningBloc(product: sl()));
  sl.registerFactory(
      () => LoginPageBloc(loginRequest: sl(), registerRequest: sl()));
  sl.registerFactory(() => HomePageBloc());

  // Use Cases
  sl.registerLazySingleton(() => GetProduct(sl()));
  sl.registerLazySingleton(() => LoginRequest(sl()));
  sl.registerLazySingleton(() => RegisterRequest(sl()));
  sl.registerLazySingleton(() => GetDiet(sl()));
  sl.registerLazySingleton(() => GetAllergen(sl()));

  // Repositories
  sl.registerLazySingleton<ScanningRepository>(
    () => ScanningRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<ScanningRemoteDataSource>(
      () => ScanningRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LoginLocalDataSource>(
      () => LoginLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(client: sl()));

  // | Core |
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // | External |
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseVision.instance.barcodeDetector());
}
