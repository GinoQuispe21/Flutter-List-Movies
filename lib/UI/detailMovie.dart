import 'package:flutter/material.dart';

class DetailMovie extends StatefulWidget {
  final String movieTitle;
  final String movieOverview;
  final String movieImage;
  const DetailMovie(
      {this.movieTitle, this.movieOverview, this.movieImage, Key key})
      : super(key: key);

  @override
  _DetailMovieState createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de pelicula"),
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            widget.movieImage,
            fit: BoxFit.fill,
            height: 400,
            width: 350,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.movieTitle,
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.movieOverview,
              textAlign: TextAlign.justify,
            ),
          )
        ],
      )),
    );
  }
}
