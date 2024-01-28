import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/respositories/number_trivia_repository.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetConcreteNumberTrivia extends Mock implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetConcreteNumberTrivia {}

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

class MockNumberTriviaBloc extends Mock implements NumberTriviaBloc {}

void main() {
  late MockGetConcreteNumberTrivia getConcreteNumberTrivia;
  late MockGetRandomNumberTrivia getRandomNumberTrivia;
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  late MockNumberTriviaBloc mockNumberTriviaBloc;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    getConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    getRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockNumberTriviaBloc = MockNumberTriviaBloc();
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: 'test', number: tNumber);
  const errorMessage = "error_message";

  group('state test', () {
    test('state should be empty', () {
      when(() => mockNumberTriviaBloc.state).thenReturn(EmptyNumberTriviaState());

      expect(mockNumberTriviaBloc.state, EmptyNumberTriviaState());
    });
    test('state should be loading', () {
      when(() => mockNumberTriviaBloc.state).thenReturn(LoadingNumberTriviaState());

      expect(mockNumberTriviaBloc.state, LoadingNumberTriviaState());
    });
    test('state should be loaded', () {
      when(() => mockNumberTriviaBloc.state)
          .thenReturn(LoadedNumberTriviaState(trivia: tNumberTrivia));

      expect(mockNumberTriviaBloc.state, LoadedNumberTriviaState(trivia: tNumberTrivia));
    });
    test('state should be error', () {
      when(() => mockNumberTriviaBloc.state)
          .thenReturn(ErrorNumberTriviaState(message: errorMessage));

      expect(mockNumberTriviaBloc.state, ErrorNumberTriviaState(message: errorMessage));
    });
  });

  group('event test', () {
    test('GetTriviaForConcreteNumberTest Error State', () {
      when(() => mockNumberTriviaBloc.add(GetTriviaForConcreteNumber(tNumber.toString())))
          .thenAnswer((invocation) async {
        _setStateToBloc(mockNumberTriviaBloc, ErrorNumberTriviaState(message: errorMessage));
      });

      mockNumberTriviaBloc.add(GetTriviaForConcreteNumber(tNumber.toString()));

      expect(mockNumberTriviaBloc.state, ErrorNumberTriviaState(message: errorMessage));
    });

    test('GetTriviaForConcreteNumberTest Loaded State', () {
      when(() => mockNumberTriviaBloc.add(GetTriviaForConcreteNumber(tNumber.toString())))
          .thenAnswer((invocation) async {
        _setStateToBloc(mockNumberTriviaBloc, LoadedNumberTriviaState(trivia: tNumberTrivia));
      });

      mockNumberTriviaBloc.add(GetTriviaForConcreteNumber(tNumber.toString()));

      expect(mockNumberTriviaBloc.state, LoadedNumberTriviaState(trivia: tNumberTrivia));
    });
  });
}

void _setStateToBloc(
    MockNumberTriviaBloc mockNumberTriviaBloc, NumberTriviaState numberTriviaState) {
  when(() => mockNumberTriviaBloc.state).thenReturn(numberTriviaState);
}
