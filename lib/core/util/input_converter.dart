import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    final integer = int.parse(str);
    try {
      if (integer < 0) throw FormatException();
      return Right(integer);
    } on FormatException {
      return Left(invalidInputFailure());
    }
  }
}

class invalidInputFailure extends Failure {
  @override
  List<Object?> get props => [];
}
