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


/*
algumas explicações mais detalhadas sobre os componentes do  código:

UseCase<Type, Params>: Isso define a interface para um caso de uso genérico. A ideia é que,
 para cada operação diferente na sua aplicação, você implementaria essa interface.
  <Type> é o tipo de valor que o caso de uso retornará quando for bem-sucedido, 
  e Params são os parâmetros necessários para o caso de uso.

Future<Either<Failure, Type>> call(Params params);: Aqui, call é um método que representa a execução do caso de uso.
 Esta função retorna um Future porque é provável que a execução do caso de uso seja assíncrona (como uma chamada de rede
  ou leitura de disco). Either<Failure, Type> é uma estrutura de dados de duas vias: o caso de uso pode falhar com um Failure 
  ou ter sucesso com um resultado de Type.

NoParams: Esta é uma classe usada quando um caso de uso não requer nenhum parâmetro para ser executado.



<Type> é usado como um placeholder para representar qualquer tipo de objeto que você quer retornar ao executar o caso de uso.
 UseCase é um padrão de design comum no desenvolvimento de software para encapsular todas as operações de negócios em uma operação 
 autônoma e permitir um alto grau de reutilização e separação de preocupações.

*/