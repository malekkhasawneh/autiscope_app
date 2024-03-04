import 'package:autiscope_app/features/login/data/datasource/login_local_datasource.dart';
import 'package:autiscope_app/features/login/data/datasource/login_remote_datasource.dart';
import 'package:autiscope_app/features/login/data/repository/login_repository_impl.dart';
import 'package:autiscope_app/features/login/domain/repository/login_repository.dart';
import 'package:autiscope_app/features/login/domain/usecase/get_user_info_usecase.dart';
import 'package:autiscope_app/features/login/domain/usecase/login_usecase.dart';
import 'package:autiscope_app/features/login/domain/usecase/set_is_login.dart';
import 'package:autiscope_app/features/login/domain/usecase/set_user_info_usecase.dart';
import 'package:autiscope_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:autiscope_app/injection_container/injection.dart';

Future<void> loginInjection() async {
  // Cubit
  sl.registerFactory(
        () => LoginCubit(
      loginUseCase: sl(),
      setUserInfoUseCase: sl(),
      getUserInfoUseCase: sl(),
      setIsLoginUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => SetUserInfoUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserInfoUseCase(repository: sl()));
  sl.registerLazySingleton(() => SetIsLoginUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(
        networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
        () => LoginRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<LoginLocalDataSource>(
        () => LoginLocalDataSourceImpl(),
  );
}
