import 'package:equatable/equatable.dart';

class WeatherForecast extends Equatable {
  final int temperature;
  final String city;
  final String weather;

  const WeatherForecast({required this.temperature, required this.city,  required this.weather});

  @override
  List<Object?> get props => [temperature, city, weather];
}
