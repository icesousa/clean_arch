import 'package:clean_arch/features/weather_forecast/data/models/weather_forecast_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherForecastModel> GetWeatherForecastForCity(String cityName);
}
