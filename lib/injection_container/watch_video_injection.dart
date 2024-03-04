import 'package:autiscope_app/features/watch_video/data/datasource/watch_video_remote_datasource.dart';
import 'package:autiscope_app/features/watch_video/data/repository/watch_video_repository_impl.dart';
import 'package:autiscope_app/features/watch_video/domain/repository/watch_video_repository.dart';
import 'package:autiscope_app/features/watch_video/domain/usecase/check_for_autism_usecase.dart';
import 'package:autiscope_app/features/watch_video/presentation/cubit/watch_video_cubit.dart';
import 'package:autiscope_app/injection_container/injection.dart';

Future<void> watchVideoInjection() async {
  // Cubit
  sl.registerFactory(
    () => WatchVideoCubit(checkForAutismUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => CheckForAutismUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<WatchVideoRepository>(
    () => WatchVideoRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<WatchVideoRemoteDataSource>(
    () => WatchVideoRemoteDataSourceImpl(),
  );
}
