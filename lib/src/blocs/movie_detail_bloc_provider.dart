import 'package:flutter/material.dart';

import 'movie_detail_bloc.dart';

/*
This class extends the InheritedWidget and provide access to the bloc through the
of(context) method. As you can see the of(context) is expecting a context as parameter.
 This context belongs to the screen which InheritedWidget has wrapped.
 In our case it is the movie detail screen.
 */

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