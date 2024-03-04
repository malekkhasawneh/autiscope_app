import 'package:autiscope_app/features/add_child/data/datasource/add_child_remote_datasource.dart';
import 'package:autiscope_app/features/add_child/data/repository/add_child_repository_impl.dart';
import 'package:autiscope_app/features/add_child/domain/repository/add_child_repository.dart';
import 'package:autiscope_app/features/add_child/domain/usecase/add_child_usecase.dart';
import 'package:autiscope_app/features/add_child/domain/usecase/get_children_usecase.dart';
import 'package:autiscope_app/features/add_child/presentation/cubit/add_child_cubit.dart';
import 'package:autiscope_app/injection_container/injection.dart';

Future<void> addChildInjection() async {
  // Cubit
  sl.registerFactory(
    () => AddChildCubit(addChildUseCase: sl(), getChildrenUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => AddChildUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetChildrenUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<AddChildRepository>(
    () => AddChildRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AddChildRemoteDataSource>(
    () => AddChildRemoteDataSourceImpl(),
  );
}
