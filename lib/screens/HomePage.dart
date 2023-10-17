import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../decoration/card.dart';
import '../decoration/gradient.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late Future<Map<String, dynamic>> weather;
  late Future<Map<String, dynamic>> weather2;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Kolkata';
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,india&APPID=58e0b7c3f6f1f2580b1a90278d8d4b8a'),
      );
      
      final data = jsonDecode(res.body);
      
      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }
  Future<Map<String, dynamic>> getCurrentWeather2() async {
    try {
      String cityName = 'Kolkata';
      
      final res2 = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=$cityName,india&APPID=58e0b7c3f6f1f2580b1a90278d8d4b8a'),
      );
      
      final data2= jsonDecode(res2.body);
      print(res2.body);
      if (data2['cod'] != '200') {
        throw 'An unexpected error occurred';
      }
      return data2;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
    weather2 = getCurrentWeather2();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final data = snapshot.data!;

          DateTime now = new DateTime.now();
          String formattedDate = DateFormat('kk:mm | EEE d MMM').format(now);
          final currentWeatherData = data['list'][0];
          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final hourlyForecast1 = data['list'][1];
          final hourlyForecast2 = data['list'][2];
          final hourlyForecast3 = data['list'][3];
          final hourlyForecast4 = data['list'][4];
          final hourlyForecast5 = data['list'][5];
          final hourlyForecast6 = data['list'][6];
          final hourlyForecast7 = data['list'][7];
          final hourlyForecast8 = data['list'][8];
          final hourlyForecast9 = data['list'][9];
          final hourlyForecast10 = data['list'][10];
          int tempinC= (currentTemp-273).toInt();

          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/HeavyRain.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: 300,
                child: Center(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24),
                          color: Colors.grey.withOpacity(0.10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              const Text(
                                'Kolkata',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 50),
                              Text(
                                'Temperature: $currentTemp K',
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Humidity:  $currentHumidity%',
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Windspeed: $currentWindSpeed km/hr',
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Pressure: $currentPressure mbar',
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 20,
                right: 320,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$formattedDate',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GradientText(
                      '$tempinC°C',
                      style: const TextStyle(fontSize: 90),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Colors.white24,
                          ]),
                    ),
                    const SizedBox(height: 270),
                    GradientText(
                      '$currentSky',
                      style: const TextStyle(fontSize: 70),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Colors.white24,
                          ]),
                    ),
                    const SizedBox(
                      height: 5,
                      width: 8,
                    ),
                    const Divider(
                      color: Colors.white70,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Cards(time: DateFormat.j().format(DateTime.parse(hourlyForecast1['dt_txt'])),temperature: (hourlyForecast1['main']['temp']-273).toInt().toString(),icon: hourlyForecast1['weather'][0]['main'] == 'Clouds' || hourlyForecast1['weather'][0]['main'] == 'Rain'? Icons.cloud: Icons.sunny),
                          Cards(time: DateFormat.j().format(DateTime.parse(hourlyForecast2['dt_txt'])),temperature: (hourlyForecast2['main']['temp']-273).toInt().toString(),icon: hourlyForecast2['weather'][0]['main'] == 'Clouds' || hourlyForecast2['weather'][0]['main'] == 'Rain'? Icons.cloud: Icons.sunny),
                          Cards(time: DateFormat.j().format(DateTime.parse(hourlyForecast3['dt_txt'])),temperature: (hourlyForecast3['main']['temp']-273).toInt().toString(),icon: hourlyForecast3['weather'][0]['main'] == 'Clouds' || hourlyForecast3['weather'][0]['main'] == 'Rain'? Icons.cloud: Icons.sunny),
                          Cards(time: DateFormat.j().format(DateTime.parse(hourlyForecast4['dt_txt'])),temperature: (hourlyForecast4['main']['temp']-273).toInt().toString(),icon: hourlyForecast4['weather'][0]['main'] == 'Clouds' || hourlyForecast4['weather'][0]['main'] == 'Rain'? Icons.cloud: Icons.sunny),
                          Cards(time: DateFormat.j().format(DateTime.parse(hourlyForecast5['dt_txt'])),temperature: (hourlyForecast5['main']['temp']-273).toInt().toString(),icon: hourlyForecast5['weather'][0]['main'] == 'Clouds' || hourlyForecast5['weather'][0]['main'] == 'Rain'? Icons.cloud: Icons.sunny),
                          Cards(time: DateFormat.j().format(DateTime.parse(hourlyForecast6['dt_txt'])),temperature: (hourlyForecast6['main']['temp']-273).toInt().toString(),icon: hourlyForecast6['weather'][0]['main'] == 'Clouds' || hourlyForecast6['weather'][0]['main'] == 'Rain'? Icons.cloud: Icons.sunny),
                          Cards(time: DateFormat.j().format(DateTime.parse(hourlyForecast7['dt_txt'])),temperature: (hourlyForecast7['main']['temp']-273).toInt().toString(),icon: hourlyForecast7['weather'][0]['main'] == 'Clouds' || hourlyForecast7['weather'][0]['main'] == 'Rain'? Icons.cloud: Icons.sunny),
                          Cards(time: DateFormat.j().format(DateTime.parse(hourlyForecast8['dt_txt'])),temperature: (hourlyForecast8['main']['temp']-273).toInt().toString(),icon: hourlyForecast8['weather'][0]['main'] == 'Clouds' || hourlyForecast8['weather'][0]['main'] == 'Rain'? Icons.cloud: Icons.sunny),
                          Cards(time: DateFormat.j().format(DateTime.parse(hourlyForecast9['dt_txt'])),temperature: (hourlyForecast9['main']['temp']-273).toInt().toString(),icon: hourlyForecast9['weather'][0]['main'] == 'Clouds' || hourlyForecast9['weather'][0]['main'] == 'Rain'? Icons.cloud: Icons.sunny),
                          Cards(time: DateFormat.j().format(DateTime.parse(hourlyForecast10['dt_txt'])),temperature: (hourlyForecast10['main']['temp']-273).toInt().toString(),icon: hourlyForecast10['weather'][0]['main'] == 'Clouds' || hourlyForecast10['weather'][0]['main'] == 'Rain'? Icons.cloud: Icons.sunny),
                        ]
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
