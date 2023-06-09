import 'package:clean_arch/core/error/exceptions.dart';
import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/core/network/network_info.dart';
import 'package:clean_arch/features/weather_forecast/data/datasources/weather_remote_data_source.dart';
import 'package:clean_arch/features/weather_forecast/domain/entities/weaterforecast.dart';
import 'package:clean_arch/features/weather_forecast/domain/repositories/weather_forecast_repository.dart';
import 'package:dartz/dartz.dart';

class WeatherForecastRepoositoryImpl implements WheatherForecastRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  WeatherForecastRepoositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, WeatherForecast>> getWeatherForecastForCity(
      String cityName) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeatherForecast =
            await remoteDataSource.GetWeatherForecastForCity(cityName);
        return Right(remoteWeatherForecast);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
