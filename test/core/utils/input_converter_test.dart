import 'package:clean_arch/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });
  group('StringToUnsignetedInt', () {
    inputConverter = InputConverter();

    test('should return a int when the  string represents an unsigned integer',
        () {
      final str = '123';
      final result = inputConverter.stringToUnsignedInteger(str);

      expect(result, Right(123));
    });

    test('should throw InvalidInputFailure when the string is not an int', () {
      final str = 'abc';
      final result = inputConverter.stringToUnsignedInteger(str);

      expect(result, Left(invalidInputFailure()));
    });

    test('should throw InvalidInputFailure when the string is a negative', () {
      final str = '-123';
      final result = inputConverter.stringToUnsignedInteger(str);

      expect(result, Left(invalidInputFailure()));
    });
  });
}
