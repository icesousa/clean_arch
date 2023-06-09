import 'package:clean_arch/features/weather_forecast/domain/entities/weaterforecast.dart';

class WeatherForecastModel extends WeatherForecast {
  WeatherForecastModel(
      {required super.city,
      required super.temperature,
      required super.weather});

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json) {
    return WeatherForecastModel(
        city: json['city'],
        weather: json['weather'],
        temperature: json['temperature']);
  }

  Map<String, dynamic> toJson() {
    return {
      "city": city,
      "weather": weather,
      "temperature": temperature
    };
  }
}
