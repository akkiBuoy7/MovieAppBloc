import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import '../models/TrailerModel.dart';
import '../resources/repository.dart';

/*

The idea behind getting the trailer list from server is, we have to pass a movieId
to the trailer API and in return it will send us the list of trailer.
To implement this idea we will be using one important feature of RxDart i.e Transformers.

Transformers mostly helps in chaining two or more Subjects and get the final result.
Idea is, if you want to pass data from one Subject to another after performing some
operations over the data. We will be using transformers to perform operation on the
 input data from the first Subject and will pipe it to the next Subject.

In our app we will be adding the movieId to the _movieId which is a PublishSubject.
 We will pass the movieId to the ScanStreamTransformer which in turn will make a
 network call the trailer API and get the results and pipe it to the _trailers
 which is a BehaviorSubject.
 */

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