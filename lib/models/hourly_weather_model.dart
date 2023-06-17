import 'dart:convert';

HourlyWeatherData hourlyWeatherDataFromJson(String str) =>
    HourlyWeatherData.fromJson(json.decode(str));

class HourlyWeatherData {
  static fromJson(decode) {}
}
