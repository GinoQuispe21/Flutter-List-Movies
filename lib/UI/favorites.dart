import 'package:flutter/material.dart';
import 'package:repaso_final_movies/UI/detailMovie.dart';
import 'package:repaso_final_movies/model/movie.dart';
import 'package:repaso_final_movies/util/dbHelper.dart';
import 'package:repaso_final_movies/util/httpHelper.dart';

class FavoritesMoviesPage extends StatefulWidget {
  const FavoritesMoviesPage({Key key}) : super(key: key);

  @override
  _FavoritesMoviesPageState createState() => _FavoritesMoviesPageState();
}

class _FavoritesMoviesPageState extends State<FavoritesMoviesPage> {
  List favorites_movies;
  int favoritesmoviesCount;

  DbHelper dbHelper;

  Future getFavoritesMovies() async {
    await dbHelper.openDb();

    favorites_movies = await dbHelper.getAllFavorite();
    setState(() {
      favorites_movies = favorites_movies;
    });
  }

  @override
  void initState() {
    favorites_movies = List();
    dbHelper = DbHelper();
    getFavoritesMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount:
            favorites_movies.length == null ? 0 : favorites_movies.length,
        itemBuilder: (BuildContext context, int index) {
          return MovieRow(favorites_movies[index]);
        },
      ),
    );
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
