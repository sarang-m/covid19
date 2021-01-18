import 'package:covid_new_app/model/covidDataModel.dart';
import 'package:flutter/cupertino.dart';

const kdateLocationTextStyle =
    TextStyle(fontSize: 20, fontWeight: FontWeight.w500);

class TestCase extends StatefulWidget {
  final CovidDataModel covidData;

  const TestCase({Key key, this.covidData}) : super(key: key);
  @override
  _TestCaseState createState() => _TestCaseState();
}

class _TestCaseState extends State<TestCase> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("h"),
    );
  }
}
