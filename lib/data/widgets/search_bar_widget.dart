import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.pink.shade500,
        child: TextField(
          style: const TextStyle(color: Colors.white),
          maxLines: 1,
          controller: _textController,
          decoration: InputDecoration(
            hintText: 'Search Location',
            suffixIcon: _textController.text.isEmpty
                ? null
                : InkWell(
                    radius: 4.0,
                    onTap: () {
                      _textController.clear();
                    },
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
            hintStyle: const TextStyle(color: Colors.white70),
            errorText: Provider.of<WeatherProvider>(context).error,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            icon: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: _textController.text.isEmpty ? 12.0 : 14.0,
              bottom: _textController.text.isEmpty ? 12.0 : 0.0,
            ),
          ),
          onChanged: (value) =>
              Provider.of<WeatherProvider>(context, listen: false).error = null,
          onSubmitted: (query) {
            if (_textController.text.isEmpty) {
              Provider.of<WeatherProvider>(context, listen: false).error =
                  'Please enter a location';
            } else {
              Provider.of<WeatherProvider>(context, listen: false)
                  .searchWeather(query);
            }
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }
}
