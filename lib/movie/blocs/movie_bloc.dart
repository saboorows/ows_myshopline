import 'dart:async';

import 'package:ows_myshopline/movie/networking/api_response.dart';
import 'package:ows_myshopline/movie/repository/movie_repository.dart';
import 'package:ows_myshopline/movie/models/movie_response.dart';

class MovieBloc {
  MovieRepository? _movieRepository;
  StreamController? _movieListController;
  StreamSink get movieListSink =>
      _movieListController!.sink;
  Stream get movieListStream => _movieListController!.stream;

  MovieBloc() {
    _movieListController = StreamController<ApiResponse<dynamic>>();
    _movieRepository = MovieRepository();
    fetchMovieList();
  }

  fetchMovieList() async {
    movieListSink.add(ApiResponse.loading('Fetching Movies'));
    try {
      List<Movie>? movies = await _movieRepository!.fetchMovieList();
      movieListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      movieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _movieListController?.close();
  }
}
