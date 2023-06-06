import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

// Interface genérica para definir um caso de uso
abstract class UseCase<Type, Params> {
  // Método assíncrono que representa a execução do caso de uso
  Future<Either<Failure, Type>> call(Params params);
}

// Classe representando a ausência de parâmetros
class NoParams extends Equatable {
  // Sobrescreve o método de comparação de igualdade para que a classe seja tratada como imutável
  @override
  List<Object?> get props => [];
}
