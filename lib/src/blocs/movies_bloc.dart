import 'package:flutter/foundation.dart';

import '../models/ItemModel.dart';
import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

/*
Inside the MoviesBloc class, we are creating the Repository class object which
will be used to access the fetchAllMovies(). We are creating a PublishSubject
object whose responsibility is to add the data which it got from the server in
the form of ItemModel object and pass it to the UI screen as a stream.

To pass the ItemModel object as stream we have created another method allMovies()
 whose return type is Stream<ItemModel>

 Last line we are creating the bloc object. This way we are giving access to a
 single instance of the MoviesBloc class to the UI screen.
 */

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<ItemModel>();

  Stream<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();