import 'package:dio/dio.dart';
import 'package:flutter_tdd_clean_architecture_course/core/error/exceptions.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int? number);

  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final Dio _dio;
  final headers = {'Content-Type': 'application/json'};

  NumberTriviaRemoteDataSourceImpl(this._dio);

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int? number) => _getNumberTrivia(number);

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() => _getNumberTrivia(null);

  Future<NumberTriviaModel> _getNumberTrivia(int? number) async {
    late Response response;
    if (number == null) {
      response =
          await _dio.get("http://numbersapi.com/random?json", options: Options(headers: headers));
    } else {
      response =
          await _dio.get("http://numbersapi.com/$number?json", options: Options(headers: headers));
    }
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
