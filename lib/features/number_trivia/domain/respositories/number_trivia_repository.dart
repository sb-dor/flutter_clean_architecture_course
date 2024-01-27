import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture_course/core/error/failuers.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int? number);

  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
