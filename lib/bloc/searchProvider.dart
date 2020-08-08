import 'package:flutter/material.dart';
import 'package:themoviesapp/model/movie.dart';

SearchProvider searchProvider = SearchProvider();

class SearchProvider with ChangeNotifier {
  List<Movie> _movies = [];

  get movies => _movies;

  set movies(List<Movie> movies) {
    _movies = movies;
    notifyListeners();
  }
}
