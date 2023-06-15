import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/core/usecases/usecases.dart';
import 'package:clean_arch/features/weather_forecast/domain/entities/weaterforecast.dart';
import 'package:clean_arch/features/weather_forecast/domain/repositories/weather_forecast_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetWeatherForecastForCity implements UseCase<WeatherForecast, Params> {
  WheatherForecastRepository repository;

  GetWeatherForecastForCity(this.repository);

  @override
  Future<Either<Failure, WeatherForecast>> call(Params params) async {
    return await repository.getWeatherForecastForCity(params.cityName);
  }
}

class Params extends Equatable {
  final String cityName;
  const Params(this.cityName);

  @override
  List<Object?> get props => [cityName];
}
