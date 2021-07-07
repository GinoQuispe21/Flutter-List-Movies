import 'package:flutter/material.dart';
import 'package:repaso_final_movies/UI/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "My Movies",
    theme: ThemeData(primarySwatch: Colors.green),
    home: Home(),
  ));
}
