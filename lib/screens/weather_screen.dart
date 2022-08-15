import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData});

  final parseWeatherData;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late String cityName;
  late int temp;
  late String currentTime = getSystemTime();
  var date = DateTime.now();

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData);
  }

  void updateData(dynamic weatherData) {
    cityName = weatherData['name'];
    temp = weatherData['main']['temp'].toInt();

    print(cityName);
    print(temp);
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.near_me),
            onPressed: () {},
            iconSize: 30.0,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.location_searching),
              onPressed: () {},
              iconSize: 30.0,
            ),
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              Image.asset(
                'image/background.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150.0,
                              ),
                              Text(
                                'Seoul',
                                style: TextStyle(
                                    fontSize: 35.0, color: Colors.white),
                              ),
                              Row(
                                children: [
                                  TimerBuilder.periodic(Duration(minutes: 1),
                                      builder: (context) {
                                    return Text(
                                      currentTime,
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.white),
                                    );
                                  }),
                                  Text(
                                    DateFormat(' - EEEE, ').format(date),
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  ),
                                  Text(
                                    DateFormat('d MM, yyy').format(date),
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '18\u2103',
                                style: TextStyle(
                                    fontSize: 85.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset('svg/climacon-sun.svg'),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'clear sky',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                            height: 15.0, thickness: 2.0, color: Colors.white),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'AQI(대기질 지수)',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Image.asset('image/bad.png',
                                  width: 37.0,
                                  height: 35.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '매우 나쁨',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '미세먼지',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '174.75',
                                  style: TextStyle(
                                      fontSize: 24.0, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '㎍/㎥',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '초미세먼지',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '84.03',
                                  style: TextStyle(
                                      fontSize: 24.0, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '㎍/㎥',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
