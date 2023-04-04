import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import '../models/TrailerModel.dart';
import '../resources/repository.dart';

class MovieDetailBloc {
  final _repository = Repository();
  final _movieId = PublishSubject<int>();
  final _trailers = BehaviorSubject<Future<TrailerModel>>();

  Function(int) get fetchTrailersById => _movieId.sink.add;
  ValueStream<Future<TrailerModel>> get movieTrailers => _trailers.stream;

  MovieDetailBloc() {
    _movieId.stream.transform(_itemTransformer()).pipe(_trailers);
  }

  dispose() async {
    _movieId.close();
    await _trailers.drain();
    _trailers.close();
  }


  _itemTransformer() {
    return ScanStreamTransformer(
            (Future<TrailerModel> trailer, int id, int index) {
          print(index);
          trailer = _repository.fetchTrailers(id);
          return trailer;
        },emptyFutureTrailerModel()
    );
  }

  Future<TrailerModel> emptyFutureTrailerModel() async
  {
    return TrailerModel(id: null, results: []);
  }
  
}