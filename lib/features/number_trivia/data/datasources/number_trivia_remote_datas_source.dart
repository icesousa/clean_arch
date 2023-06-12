import 'dart:convert';
import 'package:clean_arch/core/error/exceptions.dart';
import 'package:http/http.dart ' as http;
import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all erros codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  ///Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}



class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async =>
      _getTriviaFrom(number);

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async =>
      _getTriviaFrom('random');

  Future<NumberTriviaModel> _getTriviaFrom<T>(T endpoint) async {
    Uri randomEndPoint = Uri.http('numbersapi.com', '/$endpoint');

    final result = await client
        .get(randomEndPoint, headers: {'Content-Type': 'application/json'});

    if (result.statusCode == 200 && result.statusCode < 299) {
      final jsonTriviaModel = json.decode(result.body);

      return NumberTriviaModel.fromJson(jsonTriviaModel);
    } else {
      throw ServerException();
    }
  }
}
