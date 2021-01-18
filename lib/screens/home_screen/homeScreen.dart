import 'package:covid_new_app/Theme/my_text_styles.dart';
import 'package:covid_new_app/model/covidDataModel.dart';
import 'package:covid_new_app/screens/home_screen/local_widgets/global_data_piechart.dart';
import 'package:covid_new_app/services/covid_virus_data_service.dart';
import 'package:covid_new_app/widgets/error_alert.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<CovidDataModel> futureCovidDataModel;
  var date;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    getDate();
    futureCovidDataModel = CovidVirusDataService().fetchData();
  }

  Future getDate() async {
    CovidVirusDataService().fetchData().then((value) {
      setState(() {
        date = value.date;
        date = DateFormat('EEEE d MMMM y').format(date);
        print(date);
      });
    });
  }

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print(position);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: futureCovidDataModel,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return dataColoumn(covidData: snapshot.data, date: date);
                } else if (snapshot.hasError) {
                  return ErrorAlert(
                    errorMessage: "Connection error",
                    onRetryButtonPressed: () {
                      setState(() {
                        getData();
                      });
                    },
                  );
                }
            }
            return Container();
          },
        ),
      ),
    );
  }
}

Column dataColoumn({CovidDataModel covidData, var date}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        date == null ? "test" : date.toString(),
        textAlign: TextAlign.center,
        style: kdateLocationTextStyle,
      ),
      Text(
        "Global",
        style: kdateLocationTextStyle,
      ),
      Text(
        "Total case : ${covidData.global.totalConfirmed}",
        style: kdateLocationTextStyle,
      ),
      GlobalDataPiechart(
        covidData: covidData,
      ),
    ],
  );
}
