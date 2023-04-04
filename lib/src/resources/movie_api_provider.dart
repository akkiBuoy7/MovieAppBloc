import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';

import '../models/ItemModel.dart';
import '../models/TrailerModel.dart';

/*
fetchMovieList() method is making the network call to the API. Once the network
 call is complete it’s returning a Future ItemModel object if the network call
 was successful or it will throw an Exception.

fetchTrailer(movie_id) is the method which we make the hit the API and convert
the JSON response to a TrailerModel object and return a Future<TrailerModel>.
 */

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '97458e4f001f0b60b40f39e6ed03c7b3';
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  Future<ItemModel> fetchMovieList() async {
    print("entered");
    final response = await client
        .get(Uri.parse("$_baseUrl/popular?api_key=$_apiKey"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response =
    await client.get(Uri.parse("$_baseUrl/$movieId/videos?api_key=$_apiKey"));

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}