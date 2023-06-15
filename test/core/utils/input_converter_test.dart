// ignore_for_file: prefer_const_constructors

import 'package:clean_arch/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });
  group('StringToUnsignetedInt', () {
    inputConverter = InputConverter();

    test('should return a int when the  string represents an unsigned integer',
        () {
      const str = '123';
      final result = inputConverter.stringToUnsignedInteger(str);

      expect(result, Right(123));
    });

    test('should throw InvalidInputFailure when the string is not an int', () {
      const str = 'tata';
      final result = inputConverter.stringToUnsignedInteger(str);

      expect(result, Left(InvalidInputFailure()));
    });

    test('should throw InvalidInputFailure when the string is a negative', () {
      const str = '-123';
      final result = inputConverter.stringToUnsignedInteger(str);

      expect(result, Left(InvalidInputFailure()));
    });

    

  });
}
