import 'dart:async';
import '../models/ItemModel.dart';
import '../models/TrailerModel.dart';
import 'movie_api_provider.dart';

/*
We are importing the movie_api_provider.dart file and calling its fetchMovieList()
 method. This Repository class is the central point from where the data will flow
 to the BLOC.
 */

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();

  Future<TrailerModel> fetchTrailers(int movieId) =>
      moviesApiProvider.fetchTrailer(movieId);
}
