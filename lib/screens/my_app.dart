import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/providers/weather_provider.dart';
import '../widgets/search_bar_widget.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Weather App',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                _buildSearchBar(),
                _buildWeatherDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SearchBarWidget(),
    );
  }

  Widget _buildWeatherDetails() {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProv, _) {
        if (weatherProv.isLoading) {
          return const CircularProgressIndicator();
        } else if (weatherProv.weather != null) {
          final weather = weatherProv.weather!;
          return Column(
            children: [
              _buildWeatherContainer(weatherProv),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Weather Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              _buildDivider(),
              const SizedBox(
                height: 20,
              ),
              _buildWeatherInfo('Temperature',
                  '${weather.temperature.toStringAsFixed(2)} °C'),
              _buildWeatherInfo('Weather Condition', weather.weatherCondition),
              _buildWeatherInfo('Wind Speed', '${weather.windSpeed} m/s'),
            ],
          );
        } else if (weatherProv.error != null) {
          return Text('Error: ${weatherProv.error}');
        } else {
          return const SizedBox(); // Placeholder for your UI when no data is available
        }
      },
    );
  }

  Widget _buildWeatherContainer(WeatherProvider weatherProv) {
    final weatherImagePath = weatherProv.getWeatherImagePath();

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _buildWeatherRow(weatherImagePath,
                '${weatherProv.weather?.temperature.toStringAsFixed(2)} °C'),
            _buildWeatherRow(
                'assets/wind.png', '${weatherProv.weather?.windSpeed} m/s'),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherRow(String imagePath, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 34),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.pink.shade500,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                imagePath,
                height: 80,
                width: 80,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                ' $text',
                style: const TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: Divider(
        color: Colors.grey.withOpacity(0.8),
        height: 0,
        thickness: 2,
      ),
    );
  }

  Widget _buildWeatherInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$title: $value',
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
