import 'package:autiscope_app/features/splash/data/datasource/splash_local_datasource.dart';
import 'package:autiscope_app/features/splash/data/repository/splash_repository_impl.dart';
import 'package:autiscope_app/features/splash/domain/repository/splash_repository.dart';
import 'package:autiscope_app/features/splash/domain/usecase/get_is_first_time_usecase.dart';
import 'package:autiscope_app/features/splash/domain/usecase/is_login_usecase.dart';
import 'package:autiscope_app/features/splash/domain/usecase/set_is_first_time_usecase.dart';
import 'package:autiscope_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:autiscope_app/injection_container/injection.dart';

Future<void> splashInjection() async {
  // Cubit
  sl.registerFactory(
    () => SplashCubit(
      isLoginUseCase: sl(),
      setIsFirstTimeUseCase: sl(),
      getIsFirstTimeUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => IsLoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => SetIsFirstTimeUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetIsFirstTimeUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SplashLocalDataSource>(
    () => SplashLocalDataSourceImpl(),
  );
}
