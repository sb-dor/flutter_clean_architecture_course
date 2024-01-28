import 'dart:convert';

import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences _sharedPreferences;

  NumberTriviaLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final jsonString = _sharedPreferences.getString('cached_number_trivia');
    if (jsonString == null) return const NumberTriviaModel(text: 'No cached value', number: 1);
    Map<String, dynamic> json = jsonDecode(jsonString);
    return NumberTriviaModel.fromJson(json);
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel) async {}
}
