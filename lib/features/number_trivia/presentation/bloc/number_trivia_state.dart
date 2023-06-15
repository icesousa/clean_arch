import 'package:equatable/equatable.dart';

import 'package:clean_arch/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  const Loaded({required this.trivia}) : super();

  @override
  List<Object> get props => [trivia];
}

class Error extends NumberTriviaState {
  final String message;

  @override
  List<Object> get props => [message];

  const Error({required this.message}) : super();
}

/*


enum NumberTriviaStatus {intial, loading, success, error,}

class NumberTriviaState extends Equatable {
  final NumberTrivia numberTrivia;
  final NumberTriviaStatus status;
  final String message;

  NumberTriviaState({
    required this.numberTrivia,
    required this.status,
    required this.message,
  });

  factory NumberTriviaState.initial() => NumberTriviaState(numberTrivia: NumberTrivia(text: '', number: 0), status: NumberTriviaStatus.intial, message: '',);

  NumberTriviaState copyWith({
    NumberTrivia? numberTrivia,
    NumberTriviaStatus? status,
    String? message,
  }) {
    return NumberTriviaState(
      numberTrivia: numberTrivia ?? this.numberTrivia,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [numberTrivia, status, message,];
}
*/