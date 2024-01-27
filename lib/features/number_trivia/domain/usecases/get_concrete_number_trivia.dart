import 'package:flutter_tdd_clean_architecture_course/core/error/failuers.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/respositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository _numberTriviaRepository;

  GetConcreteNumberTrivia(this._numberTriviaRepository);

  // callable class will be called with "call" keyword for function
  // it means that instead of writing any other function and use that writing both class and function name,
  // you just call the object of class and pass the parameters

  // var object = GetConcreteNumberTrivia(value);

  // it can be called like : object(10);
  // and can be called like this too : object.call(10)

  Future<Either<Failure, NumberTrivia>> call({required int? number}) async {
    return await _numberTriviaRepository.getConcreteNumberTrivia(number);
  }
}
