import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:beeflix/models/movie_detail_model.dart';
import 'package:beeflix/models/movie_model.dart';

class ApiSerivce {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String now = "now-playing";
  static const String coming = "coming-soon";
  
  static Future<List<MovieModel>> fetchMovies(String category) async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$category');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body);
      for (var movie in movies["results"]) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getPopularMovies() async {
    return fetchMovies(popular);
  }

  static Future<List<MovieModel>> getMoviesNow() async {
    return fetchMovies(now);
  }

  static Future<List<MovieModel>> getComingMovies() async {
    return fetchMovies(coming);
  }

  static Future<MovieDetailModel> getMovieById(num id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    }
    throw Error();
  }
}