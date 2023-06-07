import 'package:clean_arch/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had internet connection.
  /// 
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();


  Future<void> cacheNumberTrivia(NumberTriviaModel triviaTocache);
}
