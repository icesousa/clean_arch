import 'package:clean_arch/features/weather_forecast/domain/entities/weaterforecast.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class WheatherForecastRepository {
  Future<Either<Failure, WeatherForecast>> getWeatherForecastForCity(
      String cityName);
}
