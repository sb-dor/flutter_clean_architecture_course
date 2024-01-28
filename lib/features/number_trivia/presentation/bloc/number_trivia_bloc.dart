import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tdd_clean_architecture_course/core/error/failuers.dart';
import 'package:flutter_tdd_clean_architecture_course/core/utils/string_converter.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/respositories/number_trivia_repository.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

const String serverErrorMessage = 'Server error message';
const String cacheErrorMessage = 'Cache error message';
const String otherError = 'Other error message';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final StringConverter _stringConverter = StringConverter();
  late final GetConcreteNumberTrivia _getConcreteNumberTrivia;
  late final GetRandomNumberTrivial _getTriviaForRandomNumber;
  late final NumberTriviaRepository _numberTriviaRepository;

  NumberTriviaBloc(
    this._numberTriviaRepository,
  ) : super(EmptyNumberTriviaState()) {
    _getConcreteNumberTrivia = GetConcreteNumberTrivia(_numberTriviaRepository);
    _getTriviaForRandomNumber = GetRandomNumberTrivial(_numberTriviaRepository);

    on<GetTriviaForConcreteNumber>((event, emit) async {
      var data = await _getConcreteNumberTrivia(
          number: _stringConverter.stringConverter(event.numberString));

      var dataFold = data.fold(
          (left) => ErrorNumberTriviaState(
                message: _errorMessage(left),
              ),
          (right) => LoadedNumberTriviaState(trivia: right));

      emit(dataFold);
    });

    on<GetTriviaForRandomNumber>((event, emit) async {
      var data = await _getTriviaForRandomNumber();

      var dataFold = data.fold(
          (left) => ErrorNumberTriviaState(
                message: _errorMessage(left),
              ),
          (right) => LoadedNumberTriviaState(trivia: right));

      emit(dataFold);
    });
  }

  String _errorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverErrorMessage;
      case CacheFailure:
        return cacheErrorMessage;
      default:
        return otherError;
    }
  }
}
