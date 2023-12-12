import 'package:flutter/material.dart';

import '../modal/data_modal.dart';
import '../service/api_service.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String? _error;
  List<String> _recentSearches = [];

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<String> get recentSearches => _recentSearches;

  set error(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<void> init() async {
    // Load recent searches from SharedPreferences

    notifyListeners();
  }

  Future<void> searchWeather(String cityName) async {
    try {
      error = null;
      _isLoading = true;
      notifyListeners();

      final weather = await WeatherApiService().getWeather(cityName);
      _weather = weather;
      // Add to recent searches on success
    } catch (e) {
      SnackBar(content: Text(e.toString()));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String getWeatherImagePath() {
    if (_weather != null) {
      final weatherCondition = _weather!.weatherCondition;
      return _buildWeatherImagePath(weatherCondition);
    } else {
      return 'assets/images/default.png'; // Placeholder image for no data
    }
  }

  String _buildWeatherImagePath(String weatherCondition) {
    String imagePath = 'assets/';

    // Add more conditions based on your specific weather conditions
    if (weatherCondition == 'Clear') {
      imagePath += 'clear.png';
    } else if (weatherCondition == 'Clouds') {
      imagePath += 'cloudy.png';
    } else if (weatherCondition == 'Smoke') {
      imagePath += 'fog.png';
    } else {
      imagePath += 'fog.png'; // Placeholder image for other conditions
    }

    return imagePath;
  }

  // void _addToRecentSearches(String cityName) async {
  //   if (!_recentSearches.contains(cityName)) {
  //     // Add to recent searches if not already present
  //     _recentSearches.insert(0, cityName);
  //     if (_recentSearches.length > 3) {
  //       // Keep only the last 3 searches
  //       _recentSearches.removeLast();
  //     }
  //     await _saveRecentSearches(_recentSearches);
  //     notifyListeners();
  //   }
  // }

  // Future<List<String>> _loadRecentSearches() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getStringList('recentSearches') ?? [];
  // }

  // Future<void> _saveRecentSearches(List<String> searches) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('recentSearches', searches);
  // }
}
