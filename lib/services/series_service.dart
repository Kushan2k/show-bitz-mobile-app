import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:show_bitz/utils/constants.dart';

abstract class SeriesService {
  static Future<List?> loadPopularSeries() async {
    const url = "https://api.themoviedb.org/3/tv/popular?language=en-US&page=1";

    try {
      var response = await http.get(Uri.parse(url), headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: authToken,
      });

      if (response.statusCode != 200) {
        return null;
      }
      List<dynamic> resp = jsonDecode(response.body)['results'];
      return resp;
    } catch (error) {
      return null;
    }
  }

  static Future<List?> loadThisWeekThreanding() async {
    const url = "https://api.themoviedb.org/3/trending/tv/week?language=en-US";

    try {
      var response = await http.get(Uri.parse(url), headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: authToken,
      });

      if (response.statusCode != 200) {
        return null;
      }
      List<dynamic> resp = jsonDecode(response.body)['results'];
      // print(resp);
      return resp;
    } catch (error) {
      return null;
    }
  }

  static Future<List?> loadToday() async {
    const url =
        "https://api.themoviedb.org/3/tv/airing_today?language=en-US&page=1";

    try {
      var response = await http.get(Uri.parse(url), headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: authToken,
      });

      if (response.statusCode != 200) {
        return null;
      }
      List<dynamic> resp = jsonDecode(response.body)['results'];
      // print(resp);
      return resp;
    } catch (error) {
      return null;
    }
  }

  static Future<List?> loadTopRated() async {
    const url =
        "https://api.themoviedb.org/3/tv/top_rated?language=en-US&page=1";

    try {
      var response = await http.get(Uri.parse(url), headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: authToken,
      });

      if (response.statusCode != 200) {
        return null;
      }
      List<dynamic> resp = jsonDecode(response.body)['results'];
      // print(resp);
      return resp;
    } catch (error) {
      return null;
    }
  }
}
