import 'dart:convert';

import 'package:clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test Text');

  test('should be a subclass of a NumberTrivia entity', () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () { 

    test('should return a valid model when the JSON number is an integer', ()  async{

      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });


        test('should return a valid model when the JSON number is regardaded as a double', ()  async{

      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });
  });



group(
  "To Json",
  () {
    test('should return a JSON map containing the proper data',
    () async {
      final result = tNumberTriviaModel.toJson();

   final   Map<String, dynamic>  expectedmap = {
    "text" : "Test Text",
    "number" : 1
   };


expect(result, expectedmap);
    });
  },
);

}








