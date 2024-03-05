import 'package:autiscope_app/features/forget_password/data/datasource/forget_password_remote_datasource.dart';
import 'package:autiscope_app/features/forget_password/data/repository/forget_password_repository_impl.dart';
import 'package:autiscope_app/features/forget_password/domain/repository/forget_password_repository.dart';
import 'package:autiscope_app/features/forget_password/domain/usecase/reset_password_usecase.dart';
import 'package:autiscope_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:autiscope_app/injection_container/injection.dart';

Future<void> forgetPasswordInjection() async {
  // Cubit
  sl.registerFactory(
    () => ForgetPasswordCubit(resetPasswordUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => ResetPasswordUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<ForgetPasswordRepository>(
    () => ForgetPasswordRepositoryImpl(
        networkInfo: sl(), forgetPasswordRemoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ForgetPasswordRemoteDataSource>(
    () => ForgetPasswordRemoteDataSourceImpl(),
  );
}
