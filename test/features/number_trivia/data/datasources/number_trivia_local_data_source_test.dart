import 'dart:convert';

import 'package:clean_arch/core/error/exceptions.dart';
import 'package:clean_arch/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  const tNumberTriviaModel = NumberTriviaModel(text: 'test Trivia', number: 1);
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
    registerFallbackValue(const NumberTriviaModel(text: 'test trivia', number: 1));
  });

  group('getLastNumberTrivia', () {
    final tnumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test(
        'should return NumberTriviaModel from SharedPreferences when there is one in the cache',
        () async {
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(fixture('trivia_cached.json'));
      final result = await dataSource.getLastNumberTrivia();

      verify(() => mockSharedPreferences.getString('CACHED_NUMBER_TRIVIA'));
      expect(result, equals(tnumberTriviaModel));
    });

    test('should Throw CacheException  when there is not a cached value',
        () async {
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);
      final call = dataSource.getLastNumberTrivia;

      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('CacheNumberTrivia', () {
    setUp(() {
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);
    });

    test('should call SharedPreferences to cache the data', () async {
      dataSource.cacheNumberTrivia(tNumberTriviaModel);
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(() => mockSharedPreferences.setString(
          CACHED_NUMBER_TRIVIA, expectedJsonString));
    });
  });
}
