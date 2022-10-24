import 'dart:async';
import 'package:ows_myshopline/movie/models/movie_response.dart';
import 'package:ows_myshopline/movie/networking/api_response.dart';
import 'package:ows_myshopline/movie/repository/movie_detail_repository.dart';

class MovieDetailBloc {

  MovieDetailRepository? _movieDetailRepository;
  StreamController? _movieDetailController;
  StreamSink get movieDetailSink => _movieDetailController!.sink;
  Stream get movieDetailStream => _movieDetailController!.stream;
  MovieDetailBloc(selectedMovie) {
    _movieDetailController = StreamController<ApiResponse<dynamic>>();
    _movieDetailRepository = MovieDetailRepository();
    fetchMovieDetail(selectedMovie);
  }
  fetchMovieDetail(int selectedMovie) async {
    movieDetailSink.add(ApiResponse.loading('Fetching Details'));
    try {
      Movie details = await _movieDetailRepository!.fetchMovieDetail(selectedMovie);
      movieDetailSink.add(ApiResponse.completed(details));
    } catch (e) {
      movieDetailSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _movieDetailController?.close();
  }
}
