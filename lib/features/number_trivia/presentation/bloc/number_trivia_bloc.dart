import 'dart:async';

import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/features/number_trivia/presentation/bloc/number_trivia_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_arch/core/util/input_converter.dart';
import 'package:clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_arch/features/number_trivia/presentation/bloc/number_trivia_state.dart';
// import 'dart:developer';
// //import 'package:bloc/src/emitter.dart';
// import 'package:bloc/bloc.dart';
// import 'package:clean_arch/core/error/failures.dart';
// import 'package:clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
// import 'package:clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
// import 'package:clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
// import 'package:equatable/equatable.dart';
// import '../../../../core/usecases/usecases.dart';
// import '../../../../core/util/input_converter.dart';

// part 'number_trivia_event.dart';
// part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero';

// class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
//   final GetConcreteNumberTrivia getConcreteNumberTrivia;
//   final GetRandomNumberTrivia getRandomNumberTrivia;
//   final InputConverter inputConverter;

//   NumberTriviaBloc(
//       {required this.getConcreteNumberTrivia,
//       required this.getRandomNumberTrivia,
//       required this.inputConverter})
//       : super(Empty()) {
//     on<NumberTriviaEvent>((event, emit) async {
//       if (event is GetTriviaForConcreteNumber) {
//         final inputEither =  
//             inputConverter.stringToUnsignedInteger(event.numberString);
//         inputEither.fold(
//           (failure) {
//           emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE));
//         }, 
//         (integer) async {
//           emit(Loading());
          
//           final failureOrTrivia =
//               await getConcreteNumberTrivia(Params(number: integer));
//               emit.isDone;
//           failureOrTrivia.fold(
//             (failure) => emit(
              
//               Error(message: _mapFailureToMessage(failure)),
//             ),
            
//             (trivia)  =>  emit(Loaded(trivia: trivia))
//             ,
            
//           );
          
//         });
//       } else if (event is GetTriviaForRandomNumber) {
//         emit(Loading());
//         final failureOrTrivia = await getRandomNumberTrivia(NoParams());
//         failureOrTrivia.fold(
//             (failure) => emit(Error(message: _mapFailureToMessage(failure))),
//             (trivia) => emit(Loaded(trivia: trivia)));
//       }
//     });
//   }

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
// }



class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {

  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,}
  ) : super(NumberTriviaState.initial()) {
  on<GetTriviaForConcreteNumber>(_getNumber);
  }
  

  Future<void> _getNumber(GetTriviaForConcreteNumber event, Emitter<NumberTriviaState> emit,) async {
    final inputEither =  
            inputConverter.stringToUnsignedInteger(event.numberString);

    inputEither.fold((failure) => emit(state.copyWith(status: NumberTriviaStatus.error, message: INVALID_INPUT_FAILURE_MESSAGE,
    ),
    ), 
    (integer) async {
      emit(state.copyWith(status: NumberTriviaStatus.loading));

          final failureOrTrivia = await getConcreteNumberTrivia(Params(number: integer));

          failureOrTrivia.fold((failure) => emit(state.copyWith(status: NumberTriviaStatus.error,message: _mapFailureToMessage(failure),)), (trivia) => state.copyWith(status: NumberTriviaStatus.success, numberTrivia: trivia,));
    },);
  }
}
