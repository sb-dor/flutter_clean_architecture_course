part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {}

class EmptyNumberTriviaState extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class LoadingNumberTriviaState extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class LoadedNumberTriviaState extends NumberTriviaState {
  final NumberTrivia trivia;

  LoadedNumberTriviaState({required this.trivia});

  @override
  List<Object> get props => [trivia];
}

class ErrorNumberTriviaState extends NumberTriviaState {
  final String message;

  ErrorNumberTriviaState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
