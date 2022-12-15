import 'package:http/http.dart' as http;
import 'package:tmdb_http_assignment/models/detail_model.dart';
import 'package:tmdb_http_assignment/models/movie_model.dart';

class RemoteService {
  Future getMovies(String keyword) async {
    var client = http.Client();
    var uri = Uri.parse(
      "https://api.themoviedb.org/3/movie/$keyword?api_key=cb84c4ebc8ff302495dc57a1d34c2c25&language=en-US&page=1",
    );
    var response = await client.get(uri);
    try {
      response.statusCode == 200;
      return moviesModelFromJson(response.body);
    } catch (e) {
      return e.toString();
    }
  }

  Future getDetails(int id) async {
    var client = http.Client();
    var uri = Uri.parse(
      "https://api.themoviedb.org/3/movie/$id?api_key=cb84c4ebc8ff302495dc57a1d34c2c25&language=en-US",
    );
    var response = await client.get(uri);
    try {
      response.statusCode == 200;
      return detailModelFromJson(response.body);
    } catch (e) {
      return e.toString();
    }
  }
}
