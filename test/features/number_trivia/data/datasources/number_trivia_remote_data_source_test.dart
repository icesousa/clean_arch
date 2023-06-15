import 'dart:convert';

import 'package:clean_arch/core/error/exceptions.dart';
import 'package:clean_arch/features/number_trivia/data/datasources/number_trivia_remote_datas_source.dart';
import 'package:clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia_cached.json'), 200));
  }

  void setUpMockHttpClientUnsuccess404() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia_cached.json'), 404));
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;

    final tNumberTriviaModelJson = json.decode(fixture('trivia_cached.json'));
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(tNumberTriviaModelJson);

    setUp(() {
      const tNumber = 1;

      registerFallbackValue(Uri.http('numbersapi.com', '/$tNumber'));
    });

    test('''should perform a GET request on a URL with number
     being the endpoint and with application/json header''', () async {
      setUpMockHttpClientSuccess200();
      dataSource.getConcreteNumberTrivia(tNumber);

      verify(() =>
          mockHttpClient.get(Uri.http('numbersapi.com', '/$tNumber'), headers: {
            'Content-Type': 'application/json',
          }));
    });

    test(
        'should return NumberTrivia when the repsonse is between 200 and 299(sucess)',
        () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw ServerException when the response is not 200 (unsucess)',
        () async {
      setUpMockHttpClientUnsuccess404();

      final call = dataSource.getConcreteNumberTrivia;

      expect(() =>call(tNumber), throwsA(isA<ServerException>()));
    });
  });



  group('getRandomNumberTrivia', () {

    final tNumberTriviaModelJson = json.decode(fixture('trivia_cached.json'));
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(tNumberTriviaModelJson);

    setUp(() {

      registerFallbackValue(Uri.http('numbersapi.com', '/random'));
    });

    test('''should perform a GET request on a URL with number
     being the endpoint and with application/json header''', () async {
      setUpMockHttpClientSuccess200();
      dataSource.getRandomNumberTrivia();

      verify(() =>
          mockHttpClient.get(Uri.http('numbersapi.com', '/random'), headers: {
            'Content-Type': 'application/json',
          }));
    });

    test(
        'should return NumberTrivia when the repsonse is between 200 and 299(sucess)',
        () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSource.getRandomNumberTrivia();

      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw ServerException when the response is not 200 (unsucess)',
        () async {
      setUpMockHttpClientUnsuccess404();

      final call = dataSource.getRandomNumberTrivia;

      expect(() =>call(), throwsA(isA<ServerException>()));
    });
  });
}
