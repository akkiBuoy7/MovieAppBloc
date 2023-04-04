import 'package:flutter/material.dart';

import 'movie_detail_bloc.dart';


class MovieDetailBlocProvider extends InheritedWidget {
  final MovieDetailBloc bloc;

  MovieDetailBlocProvider({required Widget child})
      : bloc = MovieDetailBloc(),
        super(child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static MovieDetailBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<MovieDetailBlocProvider>()
    as MovieDetailBlocProvider)
        .bloc;
  }
}