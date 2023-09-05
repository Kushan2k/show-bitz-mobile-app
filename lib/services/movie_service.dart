import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:show_bitz/utils/constants.dart';
import 'package:show_bitz/utils/type.dart';

import 'package:show_bitz/utils/video.dart';

abstract class MovieService {
  //get movie details by id
  static Future<Map<String, dynamic>?> loadMovieDetails(
      {required Video movie}) async {
    var url;
    if (movie.type == Types.movie) {
      url = "https://api.themoviedb.org/3/movie/${movie.id}?language=en-US";
    } else if (movie.type == Types.series) {
      url = "https://api.themoviedb.org/3/tv/${movie.id}?language=en-US";
    }

    try {
      var response = await http.get(Uri.parse(url), headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: authToken,
      });

      if (response.statusCode != 200) {
        return null;
      }
      var resp = jsonDecode(response.body);
      // print(resp);

      return resp;
    } catch (error) {
      return null;
    }
  }

  static Future<List?> loadPopularMovies() async {
    const url =
        "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1";

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

  static Future<List?> loadUpCommingMovie() async {
    const url =
        "https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1";

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

  static Future<List?> loadMovies() async {
    const url =
        "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1";

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
}
