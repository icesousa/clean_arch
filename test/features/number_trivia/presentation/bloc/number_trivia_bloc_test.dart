import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/core/usecases/usecases.dart';
import 'package:clean_arch/core/util/input_converter.dart';
import 'package:clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_arch/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean_arch/features/number_trivia/presentation/bloc/number_trivia_event.dart';
import 'package:clean_arch/features/number_trivia/presentation/bloc/number_trivia_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
        getRandomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });
  setUpAll(() {
    registerFallbackValue(const Params(number: 1));
  });

  test('initialState should be empty', () {
    expect(bloc.state, equals(Empty()));
  });

  group('getTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tNumberParse = 1;
    const tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    test(
        'should call the input converter to validate and convert the string to an unsigned integer',
        () async {
      when(() => mockGetConcreteNumberTrivia(any()))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      when(() => mockInputConverter.stringToUnsignedInteger(any()))
          .thenReturn(const Right(tNumberParse));

      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(
          (() => mockInputConverter.stringToUnsignedInteger(any())));

      verify(() => mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('blod should emit [ERROR] when the input is invalid', () {
      when(() => mockInputConverter.stringToUnsignedInteger(any()))
          .thenReturn(Left(InvalidInputFailure()));
      final expected = equals(const Error(message: INVALID_INPUT_FAILURE_MESSAGE));

      expectLater(bloc.stream.asBroadcastStream(), emits(expected));
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });

    test('should get data from the concrete use case', () async {
      when(() => mockInputConverter.stringToUnsignedInteger(any()))
          .thenReturn(const Right(tNumberParse));
      when(() => mockGetConcreteNumberTrivia(any()))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(() => mockGetConcreteNumberTrivia(any()));

      verify(() => mockGetConcreteNumberTrivia(const Params(number: tNumberParse)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      when(() => mockInputConverter.stringToUnsignedInteger(any()))
          .thenReturn(const Right(tNumberParse));
      when(() => mockGetConcreteNumberTrivia(any()))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      final expected = [Loading(), const Loaded(trivia: tNumberTrivia)];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });

    test('should emit [Loading, Error] when getting data fails',
        () async {
      when(() => mockInputConverter.stringToUnsignedInteger(any()))
          .thenReturn(const Right(tNumberParse));
      when(() => mockGetConcreteNumberTrivia(any()))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [Loading(), const Error(message: SERVER_FAILURE_MESSAGE)];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });

   test('should emit [Loading, Error] with a proper message for the error when getting data fails',
        () async {
      when(() => mockInputConverter.stringToUnsignedInteger(any()))
          .thenReturn(const Right(tNumberParse));
      when(() => mockGetConcreteNumberTrivia(any()))
          .thenAnswer((_) async => Left(CacheFailure()));

      final expected = [Loading(), const Error(message: CACHE_FAILURE_MESSAGE)];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });

  });


  group('getRandomNumberTrivia', () { 

     
    const tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');
        test('should get data from the concrete use case', () async {
    
      when(() => mockGetRandomNumberTrivia(NoParams()))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      bloc.add(GetTriviaForRandomNumber());
      await untilCalled(() => mockGetRandomNumberTrivia(NoParams()));

      verify(() => mockGetRandomNumberTrivia(NoParams()));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async {
     
      when(() => mockGetRandomNumberTrivia(NoParams()))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      final expected = [Loading(), const Loaded(trivia: tNumberTrivia)];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetTriviaForRandomNumber());
    });

    test('should emit [Loading, Error] when getting data fails',
        () async {
     
      when(() => mockGetRandomNumberTrivia(NoParams()))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [Loading(), const Error(message: SERVER_FAILURE_MESSAGE)];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetTriviaForRandomNumber());
    });

   test('should emit [Loading, Error] with a proper message for the error when getting data fails',
        () async {
     
      when(() => mockGetRandomNumberTrivia(NoParams()))
          .thenAnswer((_) async => Left(CacheFailure()));

      final expected = [Loading(), const Error(message: CACHE_FAILURE_MESSAGE)];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetTriviaForRandomNumber());
    });

  });

  }

