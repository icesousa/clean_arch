import 'package:clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  test('should get trivia for the number from repository', () async {
    const tNumber = 1;
    const tNumbertTrivia = NumberTrivia(text: 'test', number: 1);

    when(() => mockNumberTriviaRepository.getConcreteNumberTrivia(any()))
        .thenAnswer((_) async => const Right(tNumbertTrivia));

    final result = await usecase(const Params(number: tNumber));

    expect(result, const Right(tNumbertTrivia));

    verify(() => mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
  });
}
