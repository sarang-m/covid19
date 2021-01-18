import 'package:covid_new_app/model/covidDataModel.dart';
import 'package:http/http.dart' as http;

class CovidVirusDataService {
  String baseUrl = "https://api.covid19api.com/";

  Future<CovidDataModel> fetchData() async {
    http.Response response = await http.get(baseUrl + "summary");
    if (response.statusCode == 200) {
      final covidDataModel = covidDataModelFromJson(response.body);
      print("global case confirmed ${covidDataModel.global.newConfirmed}");
      return covidDataModel;
    } else {
      throw Exception("Failed to load last corona virus data");
    }
  }
}
