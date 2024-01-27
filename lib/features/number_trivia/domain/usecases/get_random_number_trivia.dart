import 'package:flutter_tdd_clean_architecture_course/core/error/failuers.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/respositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class GetRandomNumberTrivial {
  final NumberTriviaRepository _numberTriviaRepository;

  GetRandomNumberTrivial(this._numberTriviaRepository);

  Future<Either<Failure, NumberTrivia>> call() {
    return _numberTriviaRepository.getRandomNumberTrivia();
  }
}
