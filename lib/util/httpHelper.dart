import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:repaso_final_movies/model/movie.dart';

class HttpHelper {
  //api.themoviedb.org/3/movie/upcoming?api_key=3cae426b920b29ed2fb1c0749f258325

  final String urlBase = 'api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlKey = 'api_key=3cae426b920b29ed2fb1c0749f258325';
  final String urlPage = '&page=';

  Future<List> getUpcoming() async {
    final String upcoming = "https://" + urlBase + urlUpcoming + urlKey;

    print(upcoming);
    http.Response result = await http.get(Uri.parse(upcoming));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);

      final moviesMap = jsonResponse['results'];

      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();

      return movies;
    } else {
      print(result.body);

      return null;
    }
  }
}
