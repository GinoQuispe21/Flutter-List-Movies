import 'package:flutter/material.dart';
import 'package:repaso_final_movies/UI/detailMovie.dart';
import 'package:repaso_final_movies/model/movie.dart';
import 'package:repaso_final_movies/util/dbHelper.dart';
import 'package:repaso_final_movies/util/httpHelper.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List movies;
  int moviesCount;

  HttpHelper helper;

  Future initialize() async {
    movies = List();
    movies = await helper.getUpcoming();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
      print(movies[0].title);
      print(movies.length);
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        return MovieRow(movies[index]);
      },
    ));
  }
}

class MovieRow extends StatefulWidget {
  final Movie movie;
  MovieRow(this.movie);

  @override
  _MovieRowState createState() => _MovieRowState();
}

class _MovieRowState extends State<MovieRow> {
  bool favorite;
  DbHelper dbHelper;

  Future isFavorite(Movie movie) async {
    await dbHelper.openDb();
    favorite = await dbHelper.isFavorite(movie);
    setState(() {
      movie.isFavorite = favorite;
    });
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    isFavorite(widget.movie);
    favorite = false;
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        'https://image.tmdb.org/t/p/w500' + widget.movie.posterPath;
    return Card(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailMovie(
                      movieTitle: widget.movie.title,
                      movieOverview: widget.movie.overview,
                      movieImage: imageUrl,
                    )),
          );
        },
        child: ListTile(
          leading: Image.network(imageUrl),
          title: Text(widget.movie.title),
          subtitle: Text(widget.movie.overview),
          trailing: IconButton(
            icon: Icon(Icons.favorite),
            color: favorite ? Colors.red : Colors.grey,
            onPressed: () {
              favorite
                  ? dbHelper.deleteMovie(widget.movie)
                  : dbHelper.insertMovie(widget.movie);
              setState(() {
                favorite = !favorite;
                widget.movie.isFavorite = favorite;
              });
            },
          ),
        ),
      ),
    );
  }
}
