import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/respositories/number_trivia_repository.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

void main() {
  late GetConcreteNumberTrivia getConcreteNumberTrivia;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    getConcreteNumberTrivia = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  const tNumber = 1;
  const numberTrivial = NumberTrivia(text: "test", number: tNumber);

  // for testing something
  test(
    'should get trivia for the number the repository',
    () async {
      // arrange

      // it means that we are calling fake request and in this request we are setting out own value
      when(() => mockNumberTriviaRepository.getConcreteNumberTrivia(any()))
          .thenAnswer((answer) async {
        return const Right(numberTrivial);
      });
      // act
      final result = await getConcreteNumberTrivia(number: tNumber);

      // final result2 = await getConcreteNumberTrivia(number: tNumber); // if I will call this function one more time, it will not pass the test

      //assert
      expect(result, const Right(numberTrivial));

      // verification checks something (like did your any function called once or not)
      // or check did any function that you are using was called in test or not
      verify(() => mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber)).called(1);

      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
