import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:my_fl_weather/model/model.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData, this.parseAirPollutionData});

  final parseWeatherData;
  final parseAirPollutionData;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  late String cityName;
  late int temp;
  Widget? icon;
  String desc = '';
  late String currentTime = getSystemTime();
  var date = DateTime.now();

  Widget? airIcon = Image.asset('');
  Widget? airState = Text('');
  double fineDust = 0.0;
  double extraFineDust = 0.0;

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirPollutionData);
  }

  void updateData(dynamic weatherData, dynamic airData) {
    cityName = weatherData['name'];
    temp = weatherData['main']['temp'].toInt();
    desc = weatherData['weather'][0]['description'];
    int condition = weatherData['weather'][0]['id'];
    icon = model.getWeatherIcon(condition);

    int index = airData['list'][0]['main']['aqi'];
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);
    fineDust = airData['list'][0]['components']['pm2_5'];
    extraFineDust = airData['list'][0]['components']['pm10'];
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
                              SizedBox(height: 150.0,),
                              Text(
                                cityName,
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
                                '$temp\u2103',
                                style: TextStyle(
                                    fontSize: 85.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              ),
                              Row(
                                children: [
                                  icon!,
                                  SizedBox(width: 10.0),
                                  Text(
                                    desc,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white
                                    ),
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
                                SizedBox(height: 10.0,),
                                airIcon!,
                                SizedBox(height: 10.0,),
                                airState!
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
                                  fineDust.toString(),
                                  style: TextStyle(
                                      fontSize: 24.0, color: Colors.white),
                                ),
                                SizedBox(height: 10.0),
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
                                  extraFineDust.toString(),
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
