import 'dart:convert';

import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockTrivialLocalDataSourceImpl extends Mock implements NumberTriviaLocalDataSource {}

void main() {
  late MockTrivialLocalDataSourceImpl mockTrivialLocalDataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockTrivialLocalDataSourceImpl = MockTrivialLocalDataSourceImpl();
  });

  final exampleStringJson = fixture('trivia.json');

  const exampleTrivia = NumberTriviaModel(text: 'text', number: 1);

  const noCachedValue = NumberTriviaModel(text: 'No cached value', number: 1);

  group('getLastNumberTrivia', () {
    test('should return number trivia model from SharedPrefer where there is one in the cache',
        () async {
      when(() => mockSharedPreferences.getString(any()))
          .thenAnswer((invocation) => exampleStringJson);

      when(() => mockTrivialLocalDataSourceImpl.getLastNumberTrivia())
          .thenAnswer((invocation) async => exampleTrivia);

      final sharedPreferData = mockSharedPreferences.getString('name');

      final result = await mockTrivialLocalDataSourceImpl.getLastNumberTrivia();

      Map<String, dynamic> json = jsonDecode(sharedPreferData ?? '');

      final fromJson = NumberTriviaModel.fromJson(json);

      expect(result, fromJson);
    });

    test('should return optional value from SharedPrefer where there is no cached value', () async {
      when(() => mockSharedPreferences.getString(any())).thenAnswer((invocation) => null);

      final sharedPreferData = mockSharedPreferences.getString('name');

      if (sharedPreferData == null) {
        when(() => mockTrivialLocalDataSourceImpl.getLastNumberTrivia())
            .thenAnswer((invocation) async => noCachedValue);
      } else {
        when(() => mockTrivialLocalDataSourceImpl.getLastNumberTrivia())
            .thenAnswer((invocation) async => exampleTrivia);
      }

      final result = await mockTrivialLocalDataSourceImpl.getLastNumberTrivia();

      expect(result, noCachedValue);
    });
  });

  group('cacheNumberTrivia', () {
    test('should call Shared preferences and set data to cache', () async {
      when(() => mockTrivialLocalDataSourceImpl.cacheNumberTrivia(exampleTrivia))
          .thenAnswer((invocation) async => []);

      await mockTrivialLocalDataSourceImpl.cacheNumberTrivia(exampleTrivia);

      verify(() => mockTrivialLocalDataSourceImpl.cacheNumberTrivia(exampleTrivia)).called(1);
    });
  });
}
