import 'package:flutter/material.dart';
import 'package:my_fl_weather/data/my_location.dart';
import 'package:my_fl_weather/screens/weather_screen.dart';

import '../data/network.dart';
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

    print(latitude);
    print(longitude);

    Network network = Network('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey&units=metric');
    var weatherData = await network.getJsonData();
    
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData,);
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
          child: ElevatedButton(
        onPressed: () {
          getLocation();
        },
        child: Text(
          'get my location',
          style: TextStyle(color: Colors.white),
        ),
      )),
    );
  }
}
