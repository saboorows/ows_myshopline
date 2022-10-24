import 'package:ows_myshopline/movie/networking/api_base_helper.dart';
import 'package:ows_myshopline/movie/models/movie_response.dart';
import 'package:ows_myshopline/movie/apiKey.dart';

class MovieDetailRepository {
  final String? _apiKey = Api.apiKey;
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<Movie> fetchMovieDetail(int selectedMovie) async {
    final response = await _helper.get("movie/$selectedMovie?api_key=$_apiKey");
    return Movie.fromJson(response);
  }
}
