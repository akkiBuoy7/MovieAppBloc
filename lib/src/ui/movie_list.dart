import 'package:flutter/material.dart';
import '../blocs/movie_detail_bloc_provider.dart';
import '../blocs/movies_bloc.dart';
import '../models/ItemModel.dart';
import 'movie_detail.dart';

/*

 Using a StreamBuilder which will do the same job what
 StatefulWidget does i.e updating the UI (Not calling here set state method).

 MoviesBloc class is passing the new data as a stream. So to deal with streams
 we have a nice inbuilt class i.e StreamBuilder which will listen to the incoming
  streams and update the UI accordingly. StreamBuilder is expecting a stream parameter
  where we are passing the MovieBloc’s allMovies() method as it is returning a stream.
   So the moment there is a stream of data coming, StreamBuilder will re-render
   the widget with the latest data. Here the snapshot data is holding the ItemModel
   object.
 */

class MovieList extends StatefulWidget {
  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*
    NEVER make a network call inside the build method which should not be done as
    build(context) method can be called multiple times.
     */
    //bloc.fetchAllMovies();
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data?.results.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data?.results[index].posterPath}',
                fit: BoxFit.cover,
              ),
              onTap: () => openDetailPage(snapshot.data!, index),
            ),
          );
        });
  }

  // openDetailPage(ItemModel data, int index) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) {
  //       return MovieDetail(
  //         title: data.results[index].title,
  //         posterUrl: data.results[index].backdropPath,
  //         description: data.results[index].overview,
  //         releaseDate: data.results[index].releaseDate,
  //         voteAverage: data.results[index].voteAverage.toString(),
  //         movieId: data.results[index].id,
  //       );
  //     }),
  //   );
  // }



  /*
   inside the MaterialPageRoute we are returning the MovieDetailBlocProvider
   (InheritedWidget) and wrapping the MovieDetail screen into it.
   So that the MovieDetailBloc class will be accessible inside the detail screen
   and to all the widgets below it.
   */

  openDetailPage(ItemModel data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MovieDetailBlocProvider(
          child: MovieDetail(
            title: data.results[index].title,
            posterUrl: data.results[index].backdropPath,
            description: data.results[index].overview,
            releaseDate: data.results[index].releaseDate,
            voteAverage: data.results[index].voteAverage.toString(),
            movieId: data.results[index].id,
          ),
        );
      }),
    );
  }
}
