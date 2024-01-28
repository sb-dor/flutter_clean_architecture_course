import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_tdd_clean_architecture_course/core/network/network_info.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/data/data_sources/number_trivia_remote_date_source.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/respositories/number_trivia_repository.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';

var locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(Connectivity()),
  );

  var sharedPrefer = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(
    () => sharedPrefer,
  );

  locator.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(Dio()),
  );

  locator.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
      locator.get<SharedPreferences>(),
    ),
  );

  locator.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      numberTriviaLocalDataSource: locator<NumberTriviaLocalDataSource>(),
      numberTriviaRemoteDataSource: locator<NumberTriviaRemoteDataSource>(),
      networkInfo: locator<NetworkInfo>(),
    ),
  );

  locator.registerFactory(
    () => NumberTriviaBloc(
      locator<NumberTriviaRepository>(),
    ),
  );
}
