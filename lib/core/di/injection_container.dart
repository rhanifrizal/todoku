import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:todoku/core/database/secure_database.dart';
import 'package:todoku/core/presentation/bloc/app_config_bloc.dart';
import 'package:todoku/features/task/data/datasources/task_local_datasource.dart';
import 'package:todoku/features/task/data/datasources/task_local_datasource_impl.dart';
import 'package:todoku/features/task/data/repositories/task_repository_impl.dart';
import 'package:todoku/features/task/domain/repositories/task_repository.dart';
import 'package:todoku/features/task/domain/usecases/create_task.dart';
import 'package:todoku/features/task/domain/usecases/delete_task.dart';
import 'package:todoku/features/task/domain/usecases/get_tasks.dart';
import 'package:todoku/features/task/domain/usecases/update_task.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';

final GetIt sl = GetIt.instance;

/// Initialize and bind registration components across global profiles
Future<void> initInjection() async {
  // External & Core Infrastructure Layer
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    ),
  );

  // Secure Drift/SQLCipher abstraction database framework instance
  sl.registerLazySingleton<SecureDatabase>(() => SecureDatabase(sl()));

  // Data Sources Layer
  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(db: sl()),
  );

  // Repositories Layer
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(localDataSource: sl()),
  );

  // Usecase Layer
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => CreateTask(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));

  // Presentation Layer
  sl.registerFactory(
    () => TaskBloc(
      getTasks: sl(),
      createTask: sl(),
      updateTask: sl(),
      deleteTask: sl(),
    ),
  );

  sl.registerFactory(() => AppConfigBloc());
}
