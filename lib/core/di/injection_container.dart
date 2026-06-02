import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:todoku/core/database/secure_database.dart';
import 'package:todoku/core/utils/secure_storage_helper.dart';
import 'package:todoku/features/app_config/data/datasources/config_local_datasource.dart';
import 'package:todoku/features/app_config/data/datasources/config_local_datasource_impl.dart';
import 'package:todoku/features/app_config/data/repositories/config_repository_impl.dart';
import 'package:todoku/features/app_config/domain/repositories/config_repository.dart';
import 'package:todoku/features/app_config/domain/usecases/get_app_config_usecase.dart';
import 'package:todoku/features/app_config/domain/usecases/save_app_config_usecase.dart';
import 'package:todoku/features/app_config/presentation/bloc/app_config_bloc.dart';
import 'package:todoku/features/task/data/datasources/task_local_datasource.dart';
import 'package:todoku/features/task/data/datasources/task_local_datasource_impl.dart';
import 'package:todoku/features/task/data/repositories/task_repository_impl.dart';
import 'package:todoku/features/task/domain/repositories/task_repository.dart';
import 'package:todoku/features/task/domain/usecases/create_task_usecase.dart';
import 'package:todoku/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:todoku/features/task/domain/usecases/get_tasks_usecase.dart';
import 'package:todoku/features/task/domain/usecases/update_task_usecase.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';

final GetIt sl = GetIt.instance;

/// Initialize and bind registration components across global profiles
Future<void> initInjection() async {
  // External Underlying Service Engines
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // Core Utilities & Shared Data Drivers
  sl.registerLazySingleton<SecureStorageHelper>(
    () => SecureStorageHelper(sl<FlutterSecureStorage>()),
  );

  // Secure Drift/SQLCipher abstraction database framework instance
  sl.registerLazySingleton<SecureDatabase>(() => SecureDatabase(sl()));

  // Data Sources Layer
  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(db: sl()),
  );

  sl.registerLazySingleton<ConfigLocalDataSource>(
    () => ConfigLocalDataSourceImpl(storageHelper: sl()),
  );

  // Repositories Layer
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<ConfigRepository>(
    () => ConfigRepositoryImpl(localDataSource: sl()),
  );

  // Usecase Layer
  sl.registerLazySingleton(() => GetTasksUsecase(sl()));
  sl.registerLazySingleton(() => CreateTaskUsecase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUsecase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUsecase(sl()));
  sl.registerLazySingleton(() => GetAppConfigUsecase(sl()));
  sl.registerLazySingleton(() => SaveAppConfigUsecase(sl()));

  // Presentation Layer
  sl.registerFactory(
    () => TaskBloc(
      getTasksUsecase: sl(),
      createTaskUsecase: sl(),
      updateTaskUsecase: sl(),
      deleteTaskUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => AppConfigBloc(getAppConfigUsecase: sl(), saveAppConfigUsecase: sl()),
  );
}
