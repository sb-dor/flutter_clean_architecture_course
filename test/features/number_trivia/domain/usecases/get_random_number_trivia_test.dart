import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/respositories/number_trivia_repository.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

void main() {
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  late GetRandomNumberTrivial getRandomNumberTrivial;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    getRandomNumberTrivial = GetRandomNumberTrivial(mockNumberTriviaRepository);
  });

  final Random rnd = Random();
  final int randomNumber = rnd.nextInt(10);
  final NumberTrivia numberTrivia =
      NumberTrivia(text: "${rnd.nextInt(randomNumber)}_test", number: rnd.nextInt(randomNumber));

  test('should get random trivia for the number the repository', () async {
    when(() => mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((answer) async => Right(numberTrivia));

    final result = await getRandomNumberTrivial();

    // final result2 = await getRandomNumberTrivial(); // if I will call this function one more time, it will not pass the test

    expect(result, Right(numberTrivia));

    // verification checks something (like did your any function called once or not)
    // or check did any function that you are using was called in test or not
    verify(() => mockNumberTriviaRepository.getRandomNumberTrivia()).called(1);

    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
