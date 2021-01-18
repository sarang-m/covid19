import 'package:covid_new_app/Theme/colors.dart';
import 'package:covid_new_app/screens/home_screen/homeScreen.dart';
import 'package:covid_new_app/services/covid_virus_data_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
  CovidVirusDataService().fetchData();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid19',
      theme: ThemeData(
        scaffoldBackgroundColor: kbackgroundColor,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
