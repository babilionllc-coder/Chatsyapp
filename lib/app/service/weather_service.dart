import 'dart:convert';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static String get _apiKey => "YOUR_WEATHER_API_KEY_HERE";
  
  // Get current weather by city name
  static Future<Map<String, dynamic>?> getCurrentWeather({
    required String city,
    String units = 'metric', // metric, imperial, kelvin
  }) async {
    try {
      printAction("🌤️ WeatherService: Getting weather for '$city'");
      
      final uri = Uri.parse('$_baseUrl/weather');
      final queryParams = {
        'q': city,
        'appid': _apiKey,
        'units': units,
      };
      
      final response = await http.get(uri.replace(queryParameters: queryParams));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        final weatherData = {
          'city': data['name'],
          'country': data['sys']['country'],
          'temperature': data['main']['temp'],
          'feelsLike': data['main']['feels_like'],
          'humidity': data['main']['humidity'],
          'pressure': data['main']['pressure'],
          'description': data['weather'][0]['description'],
          'icon': data['weather'][0]['icon'],
          'windSpeed': data['wind']['speed'],
          'windDirection': data['wind']['deg'],
          'visibility': data['visibility'],
          'cloudiness': data['clouds']['all'],
          'sunrise': DateTime.fromMillisecondsSinceEpoch(data['sys']['sunrise'] * 1000),
          'sunset': DateTime.fromMillisecondsSinceEpoch(data['sys']['sunset'] * 1000),
          'timestamp': DateTime.now(),
        };
        
        printAction("✅ WeatherService: Weather data retrieved for $city");
        return weatherData;
        
      } else {
        printAction("❌ WeatherService: Error ${response.statusCode} - ${response.body}");
        return null;
      }
      
    } catch (e) {
      printAction("❌ WeatherService: Error getting weather - $e");
      return null;
    }
  }
  
  // Get weather forecast (5 days)
  static Future<List<Map<String, dynamic>>> getWeatherForecast({
    required String city,
    String units = 'metric',
  }) async {
    try {
      printAction("📅 WeatherService: Getting 5-day forecast for '$city'");
      
      final uri = Uri.parse('$_baseUrl/forecast');
      final queryParams = {
        'q': city,
        'appid': _apiKey,
        'units': units,
      };
      
      final response = await http.get(uri.replace(queryParameters: queryParams));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final forecasts = <Map<String, dynamic>>[];
        
        for (var item in data['list']) {
          forecasts.add({
            'dateTime': DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000),
            'temperature': item['main']['temp'],
            'feelsLike': item['main']['feels_like'],
            'humidity': item['main']['humidity'],
            'description': item['weather'][0]['description'],
            'icon': item['weather'][0]['icon'],
            'windSpeed': item['wind']['speed'],
            'cloudiness': item['clouds']['all'],
          });
        }
        
        printAction("✅ WeatherService: Retrieved ${forecasts.length} forecast entries");
        return forecasts;
        
      } else {
        printAction("❌ WeatherService: Error ${response.statusCode} - ${response.body}");
        return [];
      }
      
    } catch (e) {
      printAction("❌ WeatherService: Error getting forecast - $e");
      return [];
    }
  }
  
  // Get weather by coordinates
  static Future<Map<String, dynamic>?> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
    String units = 'metric',
  }) async {
    try {
      printAction("📍 WeatherService: Getting weather for coordinates $latitude, $longitude");
      
      final uri = Uri.parse('$_baseUrl/weather');
      final queryParams = {
        'lat': latitude.toString(),
        'lon': longitude.toString(),
        'appid': _apiKey,
        'units': units,
      };
      
      final response = await http.get(uri.replace(queryParameters: queryParams));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        final weatherData = {
          'city': data['name'],
          'country': data['sys']['country'],
          'latitude': data['coord']['lat'],
          'longitude': data['coord']['lon'],
          'temperature': data['main']['temp'],
          'feelsLike': data['main']['feels_like'],
          'humidity': data['main']['humidity'],
          'pressure': data['main']['pressure'],
          'description': data['weather'][0]['description'],
          'icon': data['weather'][0]['icon'],
          'windSpeed': data['wind']['speed'],
          'windDirection': data['wind']['deg'],
          'visibility': data['visibility'],
          'cloudiness': data['clouds']['all'],
          'sunrise': DateTime.fromMillisecondsSinceEpoch(data['sys']['sunrise'] * 1000),
          'sunset': DateTime.fromMillisecondsSinceEpoch(data['sys']['sunset'] * 1000),
          'timestamp': DateTime.now(),
        };
        
        printAction("✅ WeatherService: Weather data retrieved for coordinates");
        return weatherData;
        
      } else {
        printAction("❌ WeatherService: Error ${response.statusCode} - ${response.body}");
        return null;
      }
      
    } catch (e) {
      printAction("❌ WeatherService: Error getting weather by coordinates - $e");
      return null;
    }
  }
  
  // Format weather data for display
  static String formatWeatherData(Map<String, dynamic> weatherData) {
    final city = weatherData['city'];
    final country = weatherData['country'];
    final temp = weatherData['temperature'].toStringAsFixed(1);
    final description = weatherData['description'];
    final humidity = weatherData['humidity'];
    final windSpeed = weatherData['windSpeed'];
    
    return '''
🌤️ **Weather in $city, $country**

🌡️ **Temperature**: $temp°C
☁️ **Condition**: ${description.replaceAll('_', ' ').toUpperCase()}
💧 **Humidity**: $humidity%
💨 **Wind Speed**: $windSpeed m/s

📍 **Location**: $city, $country
🕐 **Last Updated**: ${DateTime.now().toString().substring(0, 19)}
''';
  }
}
