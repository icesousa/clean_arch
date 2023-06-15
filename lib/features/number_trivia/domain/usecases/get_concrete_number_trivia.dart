import 'package:clean_arch/core/usecases/usecases.dart';
import 'package:clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../entities/number_trivia.dart';

// Classe que implementa o caso de uso para obter uma trivia com um número concreto
class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  // Construtor que recebe uma instância do repositório
  GetConcreteNumberTrivia(this.repository);

  // Implementação do método da interface UseCase
  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    // Chama o método do repositório para obter a trivia com o número fornecido
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

// Classe que representa os parâmetros necessários para executar o caso de uso
class Params extends Equatable {
  final int number;

  // Construtor que recebe o número
  const Params({ required this.number});

  // Sobrescreve o método de comparação de igualdade para que a classe seja tratada como imutável
  @override
  List<Object?> get props => [number];
}
