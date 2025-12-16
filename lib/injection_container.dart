import 'package:get_it/get_it.dart';

import 'config/dio/dio_config.dart';
import 'config/local_storage/app_local_prefs.dart';
import 'core/constants/app_constants.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/log_in_user.dart';
import 'features/auth/presentation/provider/auth_provider.dart';
import 'features/crypto/data/repositories/crypto_repository_impl.dart';
import 'features/crypto/data/service/crypto_service.dart';
import 'features/crypto/domain/repositories/crypto_repository.dart';
import 'features/crypto/domain/usecases/encrypt_or_decrypt_data.dart';
import 'features/crypto/presentation/provider/crypto_provider.dart';
import 'features/home/data/datasources/home_local_data_source.dart';
import 'features/home/data/datasources/home_remote_data_source.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/get_local_pokemon_list.dart';
import 'features/home/domain/usecases/get_pokemon_list.dart';
import 'features/home/domain/usecases/get_pokemon_detail.dart';
import 'features/home/domain/usecases/store_pokemon_list_locally.dart';
import 'features/home/presentation/provider/home_provider.dart';
import 'features/splash/data/datasources/splash_local_data_source.dart';
import 'features/splash/data/repositories/splash_repository_impl.dart';
import 'features/splash/domain/repositories/splash_repository.dart';
import 'features/splash/domain/usecases/get_user_local_data.dart';
import 'features/splash/presentation/provider/splash_provider.dart';
import 'features/theme/data/datasources/theme_local_data_source.dart';
import 'features/theme/data/repositories/theme_repository_impl.dart';
import 'features/theme/domain/repositories/theme_repository.dart';
import 'features/theme/domain/usecases/update_user_local_data.dart';
import 'features/theme/presentation/provider/theme_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  //# Providers
  sl.registerFactory(() => SplashNotifier(getUserLocalData: sl()));
  sl.registerFactory(
    () => ThemeNotifier(getUserLocalData: sl(), updateUserLocalData: sl()),
  );
  sl.registerFactory(
    () => AuthStateNotifier(loginUser: sl(), updateUserLocalData: sl()),
  );
  sl.registerFactory(
    () => HomeStateNotifier(
      getPokemonDetail: sl(),
      getPokemonList: sl(),
      getLocalPokemonList: sl(),
      storePokemonListLocally: sl(),
      updateUserLocalData: sl(),
    ),
  );
  sl.registerFactory(() => CryptoProvider(encryptOrDecryptData: sl()));

  //# Use Cases
  sl.registerLazySingleton(() => GetUserLocalData(sl()));
  sl.registerLazySingleton(() => UpdateUserLocalData(sl()));
  sl.registerLazySingleton(() => LogInUser(sl()));
  sl.registerLazySingleton(() => GetPokemonDetail(sl()));
  sl.registerLazySingleton(() => GetPokemonList(sl()));
  sl.registerLazySingleton(() => GetLocalPokemonList(sl()));
  sl.registerLazySingleton(() => StorePokemonListLocally(sl()));
  sl.registerLazySingleton(() => EncryptOrDecryptData(sl()));

  //# Repository
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  sl.registerLazySingleton<CryptoRepository>(
    () => CryptoRepositoryImpl(cryptoService: sl()),
  );

  //# Data sources
  sl.registerLazySingleton<SplashLocalDataSource>(
    () => SplashLocalDataSourceImpl(userDBPref: sl(instanceName: userBox)),
  );
  sl.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(userDBPref: sl(instanceName: userBox)),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioClient: sl()),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(dioClient: sl()),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(pokemonDBPref: sl(instanceName: pokemonBox)),
  );
  //# Service
  sl.registerLazySingleton<CryptoService>(() => CryptoService());
  //! Core

  //! Config
  sl.registerLazySingleton(() => DioClient());

  //! User DB
  final userDB = AppLocalPrefs(userBox);
  await userDB.init();
  sl.registerLazySingleton<AppLocalPrefs>(() => userDB, instanceName: userBox);
  final pokemonDB = AppLocalPrefs(pokemonBox);
  await pokemonDB.init();
  sl.registerLazySingleton<AppLocalPrefs>(
    () => pokemonDB,
    instanceName: pokemonBox,
  );
}
