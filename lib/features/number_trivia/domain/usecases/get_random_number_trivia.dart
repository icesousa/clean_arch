import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecases.dart';

// Classe que implementa o caso de uso para obter uma trivia com um número aleatório
class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  // Construtor que recebe uma instância do repositório
  GetRandomNumberTrivia(this.repository);

  // Implementação do método da interface UseCase
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    // Chama o método do repositório para obter uma trivia com número aleatório
    return await repository.getRandomNumberTrivia();
  }
}
