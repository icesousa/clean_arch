import 'package:clean_arch/core/network/network_info.dart';
import 'package:clean_arch/core/util/input_converter.dart';
import 'package:clean_arch/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_arch/features/number_trivia/data/datasources/number_trivia_remote_datas_source.dart';
import 'package:clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:http/http.dart' as http;

final GetIt sl = GetIt.instance;
Future<void> init() async {
  //! External
  SharedPreferences sharedPref = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPref);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
  //! Features - Number Trivia

  // Blocs

  // Use Cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository

  sl.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerFactory<NumberTriviaBloc>(() => NumberTriviaBloc(getConcreteNumberTrivia: sl(), getRandomNumberTrivia: sl(), inputConverter: sl()
        // getConcreteNumberTrivia: sl(),
        // getRandomNumberTrivia: sl(),
        // inputConverter: sl(),
      ));
}
