import 'package:covid_new_app/model/covidDataModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class GlobalDataPiechart extends StatefulWidget {
  final CovidDataModel covidData;

  const GlobalDataPiechart({Key key, this.covidData}) : super(key: key);
  @override
  _GlobalDataPiechartState createState() => _GlobalDataPiechartState();
}

class _GlobalDataPiechartState extends State<GlobalDataPiechart> {
  int totalSickPeople;
  int totalRecovered;
  int totalDead;
  int totalConfirmed;
  double sickPeoplePercent;
  double recoverdPeoplePercent;
  double deadPeoplePercent;
  int touchedIndex;

  void findValues({CovidDataModel covidData}) async {
    totalDead = covidData.global.totalDeaths;
    totalConfirmed = covidData.global.totalConfirmed;
    totalRecovered = covidData.global.totalRecovered;
    totalSickPeople = covidData.global.totalConfirmed -
        covidData.global.totalRecovered -
        covidData.global.totalDeaths;
    sickPeoplePercent = (totalSickPeople * 100) / totalConfirmed;
    recoverdPeoplePercent = (totalRecovered * 100) / totalConfirmed;
    deadPeoplePercent = (totalDead * 100) / totalConfirmed;

    print("sic $sickPeoplePercent");
    print("rec $recoverdPeoplePercent");
    print("dead $deadPeoplePercent");
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                    pieTouchData:
                        PieTouchData(touchCallback: (pieTouchResponse) {
                      setState(() {
                        if (pieTouchResponse.touchInput is FlLongPressEnd ||
                            pieTouchResponse.touchInput is FlPanEnd) {
                          touchedIndex = -1;
                        } else {
                          touchedIndex = pieTouchResponse.touchedSectionIndex;
                        }
                      });
                    }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections()),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Indicator(
                    color: Colors.red,
                    text: 'Sick',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Colors.green,
                    text: 'Recovered',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Colors.blue,
                    text: 'Dead',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  // Indicator(
                  //   color: Color(0xff13d38e),
                  //   text: 'Fourth',
                  //   isSquare: true,
                  // ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      findValues(covidData: widget.covidData);
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: sickPeoplePercent,
            title: "${sickPeoplePercent.toStringAsFixed(2)}%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: recoverdPeoplePercent,
            title: "${recoverdPeoplePercent.toStringAsFixed(2)}%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blue,
            value: deadPeoplePercent,
            title: "${deadPeoplePercent.toStringAsFixed(2)}%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
