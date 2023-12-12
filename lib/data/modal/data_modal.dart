class Weather {
  final double temperature;
  final String weatherCondition;
  final double windSpeed;

  Weather({
    required this.temperature,
    required this.weatherCondition,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: (json['main']['temp'] - 273.15).toDouble(),
      weatherCondition: json['weather'][0]['main'],
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}
