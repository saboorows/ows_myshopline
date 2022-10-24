import 'package:ows_myshopline/movie/networking/api_base_helper.dart';
import 'package:ows_myshopline/movie/models/movie_response.dart';
import 'package:ows_myshopline/movie/apiKey.dart';

class MovieRepository {
  final String? _apiKey = Api.apiKey;
  ApiBaseHelper _helper = ApiBaseHelper();
  Future<List<Movie>?> fetchMovieList() async {
    final response = await _helper.get("movie/popular?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }
}
