import 'package:flutter/material.dart';
import 'package:my_fl_weather/data/my_location.dart';
import 'package:my_fl_weather/screens/weather_screen.dart';

import '../data/network.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
const apikey = 'f6526eecd6f1af5e9adcdc5ec3c1e633';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late double latitude;
  late double longitude;

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude = myLocation.latitude;
    longitude = myLocation.longitude;

    Network weatherNetwork = Network('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey&units=metric');
    var weatherData = await weatherNetwork.getJsonData();

    print('weatherData');
    print(weatherData);

    Network airNetwork = Network('http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$apikey');
    var airData = await airNetwork.getJsonData();

    print('airData');
    print(airData);
    
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData, parseAirPollutionData: airData,);
    }));
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 80.0,
        )
      )
    );
  }
}
