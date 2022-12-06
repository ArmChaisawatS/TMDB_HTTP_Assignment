import 'package:http/http.dart' as http;
import 'package:tmdb_http_assignment/models/tmdb_model.dart';

class RemoteService {
  Future getmovies() async {
    var client = http.Client();
    var uri = Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=cb84c4ebc8ff302495dc57a1d34c2c25&language=en-US&page=1");
    var response = await client.get(uri);
    try {
      response.statusCode == 200;
      return tmdbModelsFromJson(response.body);
    } catch (e) {
      return e.toString();
    }
  }
}
