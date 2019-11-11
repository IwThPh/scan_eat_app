import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:food_label_app/core/device/network_info.dart';
import 'package:food_label_app/features/scanning/data/datasources/scanning_remote_data_source.dart';
import 'package:food_label_app/features/scanning/data/repositories/scanning_repository_impl.dart';
import 'package:food_label_app/features/scanning/domain/repositories/scanning_repository.dart';
import 'package:food_label_app/features/scanning/domain/usecases/get_product.dart';
import 'package:food_label_app/features/scanning/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // | Features |
  // Bloc
  sl.registerFactory(
    () => ScanningBloc(product: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetProduct(sl()));

  // Repositories
  sl.registerLazySingleton<ScanningRepository>(
    () => ScanningRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<ScanningRemoteDataSource>(
      () => ScanningRemoteDataSourceImpl(client: sl()),
  );

  // | Core |
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // | External |
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
