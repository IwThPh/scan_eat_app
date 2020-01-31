import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:scaneat/core/device/network_info.dart';
import 'package:scaneat/features/login/data/datasources/login_remote_data_source.dart';
import 'package:scaneat/features/login/data/repositories/login_repository_impl.dart';
import 'package:scaneat/features/login/domain/repositories/login_repository.dart';
import 'package:scaneat/features/login/domain/usecases/login_request.dart';
import 'package:scaneat/features/login/presentation/bloc/login_page_bloc.dart';
import 'package:scaneat/features/scanning/data/datasources/scanning_remote_data_source.dart';
import 'package:scaneat/features/scanning/data/repositories/scanning_repository_impl.dart';
import 'package:scaneat/features/scanning/domain/repositories/scanning_repository.dart';
import 'package:scaneat/features/scanning/domain/usecases/get_product.dart';
import 'package:scaneat/features/scanning/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // | Features |
  // Bloc
  sl.registerFactory(() => ScanningBloc(product: sl()));
  sl.registerFactory(() => LoginPageBloc(request: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetProduct(sl()));
  sl.registerLazySingleton(() => LoginRequest(sl()));

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
    ),
  );

  sl.registerLazySingleton<ScanningRemoteDataSource>(
      () => ScanningRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(client: sl()));

  // | Core |
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // | External |
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
