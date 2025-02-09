import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:http/http.dart' as http;
import 'package:scaneat/core/device/network_info.dart';
import 'package:scaneat/features/home_page/data/datasources/home_remote_data_source.dart';
import 'package:scaneat/features/home_page/data/repositories/home_repository_impl.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';
import 'package:scaneat/features/home_page/domain/usecases/delete_preference.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_allergen.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_diet.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_history.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_preference.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_saved.dart';
import 'package:scaneat/features/home_page/domain/usecases/select_allergen.dart';
import 'package:scaneat/features/home_page/domain/usecases/select_diet.dart';
import 'package:scaneat/features/home_page/domain/usecases/update_preference.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/allergen/allergen_bloc.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/bloc.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/diet/diet_bloc.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/history/history_bloc.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/preference/bloc.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/saved/bloc.dart';
import 'package:scaneat/features/login/data/datasources/login_local_data_source.dart';
import 'package:scaneat/features/login/data/datasources/login_remote_data_source.dart';
import 'package:scaneat/features/login/data/repositories/login_repository_impl.dart';
import 'package:scaneat/features/login/domain/repositories/login_repository.dart';
import 'package:scaneat/features/login/domain/usecases/login_request.dart';
import 'package:scaneat/features/login/domain/usecases/logout_request.dart';
import 'package:scaneat/features/login/domain/usecases/register_request.dart';
import 'package:scaneat/features/login/domain/usecases/retrieve_user.dart';
import 'package:scaneat/features/login/presentation/bloc/login_page_bloc.dart';
import 'package:scaneat/features/product/data/datasources/product_remote_data_source.dart';
import 'package:scaneat/features/product/data/repositories/product_repository_impl.dart';
import 'package:scaneat/features/product/domain/entities/product.dart';
import 'package:scaneat/features/product/domain/repositories/product_repository.dart';
import 'package:scaneat/features/product/domain/usecases/save_product.dart';
import 'package:scaneat/features/product/domain/usecases/unsave_product.dart';
import 'package:scaneat/features/product/presentation/bloc/product/product_bloc.dart';
import 'package:scaneat/features/scanning/data/datasources/scanning_remote_data_source.dart';
import 'package:scaneat/features/scanning/data/repositories/scanning_repository_impl.dart';
import 'package:scaneat/features/scanning/domain/repositories/scanning_repository.dart';
import 'package:scaneat/features/scanning/domain/usecases/get_product.dart';
import 'package:scaneat/features/scanning/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // | Features |
  // Bloc
  sl.registerFactoryParam<ProductBloc, Product, void>(
    (Product product, _) => ProductBloc(
      product: product,
      saveProduct: sl(),
      unsaveProduct: sl(),
    ),
  );
  sl.registerFactory(() => ScanningBloc(product: sl()));
  sl.registerLazySingleton(
    () => LoginPageBloc(
      loginRequest: sl(),
      logoutRequest: sl(),
      registerRequest: sl(),
      retrieveUser: sl(),
    ),
  );
  sl.registerFactory(() => HomePageBloc());
  sl.registerLazySingleton(() => AllergenBloc(
        getAllergen: sl(),
        selectAllergen: sl(),
      ));
  sl.registerLazySingleton(() => DietBloc(
        getDiet: sl(),
        selectDiet: sl(),
      ));
  sl.registerLazySingleton(() => PreferenceBloc(
        getPreference: sl(),
        updatePreference: sl(),
        deletePreference: sl(),
      ));
  sl.registerFactory(() => HistoryBloc(getHistory: sl()));
  sl.registerFactory(() => SavedBloc(getSaved: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetProduct(sl()));
  sl.registerLazySingleton(() => SaveProduct(sl()));
  sl.registerLazySingleton(() => UnsaveProduct(sl()));
  sl.registerLazySingleton(() => LoginRequest(sl()));
  sl.registerLazySingleton(() => LogoutRequest(sl()));
  sl.registerLazySingleton(() => RegisterRequest(sl()));
  sl.registerLazySingleton(() => RetrieveUser(sl()));
  sl.registerLazySingleton(() => GetDiet(sl()));
  sl.registerLazySingleton(() => SelectDiet(sl()));
  sl.registerLazySingleton(() => GetAllergen(sl()));
  sl.registerLazySingleton(() => SelectAllergen(sl()));
  sl.registerLazySingleton(() => GetPreference(sl()));
  sl.registerLazySingleton(() => UpdatePreference(sl()));
  sl.registerLazySingleton(() => DeletePreference(sl()));
  sl.registerLazySingleton(() => GetHistory(sl()));
  sl.registerLazySingleton(() => GetSaved(sl()));

  // Repositories
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<ScanningRepository>(
    () => ScanningRepositoryImpl(
      networkInfo: sl(),
      localDataSource: sl(),
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
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));

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
