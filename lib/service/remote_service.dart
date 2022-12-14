import 'package:http/http.dart' as http;
import 'package:tmdb_http_assignment/models/detail_model.dart';
import 'package:tmdb_http_assignment/models/nowplaying_model.dart';
import 'package:tmdb_http_assignment/models/toprate_model.dart';
import 'package:tmdb_http_assignment/models/popular_model.dart';

class RemoteService {
  Future getPopularMovies() async {
    var client = http.Client();
    var uri = Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=cb84c4ebc8ff302495dc57a1d34c2c25&language=en-US&page=1");
    var response = await client.get(uri);
    try {
      response.statusCode == 200;
      return popularModelFromJson(response.body);
    } catch (e) {
      return e.toString();
    }
  }

  Future getTopRateMovies() async {
    var client = http.Client();
    var uri = Uri.parse(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=cb84c4ebc8ff302495dc57a1d34c2c25&language=en-US&page=1");
    var response = await client.get(uri);
    try {
      response.statusCode == 200;
      return topRateModelFromJson(response.body);
    } catch (e) {
      return e.toString();
    }
  }

  Future getNowPlayingMovies() async {
    var client = http.Client();
    var uri = Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=cb84c4ebc8ff302495dc57a1d34c2c25&language=en-US&page=1");
    var response = await client.get(uri);
    try {
      response.statusCode == 200;
      return nowplayingModelFromJson(response.body);
    } catch (e) {
      return e.toString();
    }
  }

  Future getDetails(int id) async {
    var client = http.Client();
    var uri = Uri.parse(
        "https://api.themoviedb.org/3/movie/$id?api_key=cb84c4ebc8ff302495dc57a1d34c2c25&language=en-US");
    var response = await client.get(uri);
    try {
      response.statusCode == 200;
      return detailModelFromJson(response.body);
    } catch (e) {
      return e.toString();
    }
  }
}
