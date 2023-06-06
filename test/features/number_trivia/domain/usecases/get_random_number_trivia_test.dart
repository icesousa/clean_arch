import 'package:clean_arch/core/usecases/usecases.dart';
import 'package:clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  test('should get trivia from the repository', () async {
    
    final tNumbertTrivia = NumberTrivia(text: 'test', number: 1);

    when(() => mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(tNumbertTrivia));

    final result = await usecase(NoParams());

    expect(result, Right(tNumbertTrivia));

    verify(() => mockNumberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
