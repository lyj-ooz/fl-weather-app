import 'package:flutter/material.dart';
import 'package:my_fl_weather/data/my_location.dart';

import '../data/network.dart';

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

    Network network = Network('https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1');
    var weatherData = await network.getJsonData();
    print(weatherData);
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
