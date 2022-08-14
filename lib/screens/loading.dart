import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void getLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position);
    } catch (e) {
      print('에러발생');
    }
  }

  void fetchData() async {
    var httpsUri = Uri(
        scheme: 'https',
        host: 'samples.openweathermap.org',
        path: '/data/2.5/weather',
        queryParameters: {
          'q': 'London',
          'appid': 'b1b15e88fa797225412429c1c50c122a1'
        });

    print(httpsUri);

    http.Response response = await http.get(httpsUri);
    print(response.body);
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    fetchData();
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
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          )
      ),
    );
  }
}
