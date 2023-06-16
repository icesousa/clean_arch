import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/core/usecases/usecases.dart';
import 'package:clean_arch/core/util/input_converter.dart';
import 'package:clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/number_trivia.dart';
import 'number_trivia_event.dart';
import 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {required this.getConcreteNumberTrivia,
      required this.getRandomNumberTrivia,
      required this.inputConverter})
      : super(Empty()) {
    on<GetTriviaForConcreteNumber>(_getTriviaForConcreteNumber);
    on<GetTriviaForRandomNumber>(_getTriviaForRandomNumber);
  }

  Future<void> _getTriviaForConcreteNumber(
      GetTriviaForConcreteNumber event, Emitter<NumberTriviaState> emit) async {
    final inputEither =
        inputConverter.stringToUnsignedInteger(event.numberString);
    inputEither.fold(
      (failure) => emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
      (integer) async {
        emit( Loading());

        final failureOrTrivia =
            await getConcreteNumberTrivia(Params(number: integer));

        _eitherLoadedOrErrorState(failureOrTrivia, emit);
      },
    );
  }

  Future<void> _getTriviaForRandomNumber(
      GetTriviaForRandomNumber event, Emitter<NumberTriviaState> emit) async {
    emit(Loading());
    final failureOrTrivia = await getRandomNumberTrivia(NoParams());

    _eitherLoadedOrErrorState(failureOrTrivia, emit);
  }

  void _eitherLoadedOrErrorState(Either<Failure, NumberTrivia> failureOrTrivia,
      Emitter<NumberTriviaState> emit) {
    failureOrTrivia
        .fold((failure) => emit(Error(message: _mapFailureToMessage(failure))),
            (trivia) {
              
      emit(Loaded(
          trivia: NumberTrivia(text: trivia.text, number: trivia.number)));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
