import 'dart:io';

import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_arch/features/number_trivia/data/datasources/number_trivia_remote_datas_source.dart';

import 'package:clean_arch/features/number_trivia/domain/entities/number_trivia.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../models/number_trivia_model.dart';
// Importação de bibliotecas e arquivos necessários.

typedef _ConcreteOrRandomChoose = Future<NumberTriviaModel> Function();

// O repositório implementa uma interface definida no domínio do aplicativo.
//Isso é chamado de princípio de inversão de dependência: as camadas de alto nível (domínio)
//não devem depender das camadas de baixo nível (dados), ambos devem depender de abstrações.
class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  // As fontes de dados que o repositório usa são injetadas via construtor.
  //Isso é chamado de injeção de dependência, que é uma forma de alcançar a inversão de controle
  // (a criação de objetos é controlada por uma entidade externa).
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  // Este método retorna trivia de número específico. Ele primeiro verifica a conexão com a internet.
  // Se estiver conectado, busca dados da fonte remota, caso contrário, busca dados do cache local.
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  // Este método retorna trivia aleatória do número. Ele também primeiro verifica a conexão com a internet.
  // Se estiver conectado, busca dados da fonte remota, caso contrário, busca dados do cache local.
  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  // Este método auxiliar é usado para evitar a duplicação de código entre os métodos getConcreteNumberTrivia e getRandomNumberTrivia.
  // Ele aceita uma função que retorna um Future<NumberTriviaModel>, que é o tipo de dado que ambas as fontes de dados retornam.
  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChoose getConcreteOrRandom) async {
    // Se estiver conectado à internet, tente obter dados da fonte remota.
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        await localDataSource
            .cacheNumberTrivia(remoteTrivia); // Cache the data for future use.
            print('$remoteTrivia');
        return  Future.value(
            Right(remoteTrivia)); // Use Right to indicate success.
      } on ServerException {
        // Se ocorrer um ServerException, retorne um ServerFailure. Use Left para indicar falha.
        return Left(ServerFailure());
      } on SocketException{
        return Left(ServerFailure());
      }
    } else {
      // Se não estiver conectado à internet, tente obter dados do cache local.
      try {
        final localTrivia = localDataSource.getLastNumberTrivia();
        return Right(await localTrivia); // Use Right to indicate success.
      } on CacheException {
        // Se ocorrer um CacheException, retorne um CacheFailure. Use Left para indicar falha.
        return Left(CacheFailure());
      }
    }
  }
}
