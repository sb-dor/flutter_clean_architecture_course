import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/data/data_sources/number_trivia_remote_date_source.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockNumberTriviaRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

class MockDio extends Mock implements Dio {}

void main() {
  late MockNumberTriviaRemoteDataSource mockNumberTriviaRemoteDataSource;
  late MockDio mockDio;
  setUp(() {
    mockDio = MockDio();
    mockNumberTriviaRemoteDataSource = MockNumberTriviaRemoteDataSource();
  });

  const int number = 1;
  const NumberTriviaModel tNumberTriviaModel = NumberTriviaModel(text: 'text', number: number);
  final headers = {'Content-Type': 'application/json'};
  const firstUrl = 'http://numbersapi.com/$number';

  group('remote data source test', () {
    test('should return data from json', () async {
      when(() => mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(any()))
          .thenAnswer((invocation) async => tNumberTriviaModel);

      final result = await mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(number);

      expect(result, tNumberTriviaModel);

      verify(() => mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(number)).called(1);
    });

    test('should return data from json using dio', () async {
      // Create a Completer to create a completed Future with the expected result

      // Stub the mock to return the completed Future
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response<dynamic>(
          data: fixture('trivia.json'),
          statusCode: 200,
          requestOptions: RequestOptions(data: fixture('trivia.json')),
        ),
      );

      var response = await mockDio.get(firstUrl);

      Map<String, dynamic> json = jsonDecode(response.data);

      var result = NumberTriviaModel.fromJson(json);

      expect(result, tNumberTriviaModel);
    });
  });
}
