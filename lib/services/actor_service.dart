import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:show_bitz/utils/constants.dart';

abstract class ActorService {
  static Future<List?> loadActors() async {
    const String url =
        '''https://api.themoviedb.org/3/trending/person/week?language=en-US''';

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

  static Future<Map<String, dynamic>?> loadActorDetails(
      {required int id}) async {
    var url = "https://api.themoviedb.org/3/person/$id?language=en-US";

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

  static Future getImages({required int id}) async {
    var url = "https://api.themoviedb.org/3/person/$id/images";

    try {
      var response = await http.get(Uri.parse(url), headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: authToken,
      });

      if (response.statusCode != 200) {
        return null;
      }
      var resp = jsonDecode(response.body);
      // print(resp['profiles']);

      return resp['profiles'];
    } catch (error) {
      return null;
    }
  }
}
