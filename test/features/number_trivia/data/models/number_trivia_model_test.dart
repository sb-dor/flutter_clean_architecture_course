import 'dart:convert';

import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tNumberTrivialModel = NumberTriviaModel(number: 1, text: "text");

  test('should be a subclass of NumberTrivia entity', () {
    expect(tNumberTrivialModel, isA<NumberTrivia>());
  });

  group("fromJson - test", () {
    test('first json integer test', () {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTrivialModel);
    });

    test('second json double test', () {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTrivialModel);
    });
  });

  group('Json - test', () {
    test('is the model is json', () {
      final data = tNumberTrivialModel.toJson();

      final result = {
        "text": "text",
        "number": 1,
      };

      expect(result, data);
    });
  });
}
