import 'package:autiscope_app/features/signup/data/datasource/sign_up_local_datasource.dart';
import 'package:autiscope_app/features/signup/data/repository/sign_up_repository_impl.dart';
import 'package:autiscope_app/features/signup/domain/repository/sign_up_repository.dart';
import 'package:autiscope_app/features/signup/domain/usecase/sign_up_usecase.dart';
import 'package:autiscope_app/features/signup/presentation/cubit/sign_up_cubit.dart';
import 'package:autiscope_app/injection_container/injection.dart';

Future<void> signUpInjection() async {
  // Cubit
  sl.registerFactory(
    () => SignUpCubit(
      signUpUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SignUpRemoteDataSource>(
    () => SignUpRemoteDataSourceImpl(),
  );
}
