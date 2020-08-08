import 'package:flutter/foundation.dart';
import 'package:themoviesapp/model/movie.dart';
import 'package:themoviesapp/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

class BlocMoviesSearch {
  final Repository _repository = Repository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  BehaviorSubject<MovieResponse> get subject => _subject;

  getMovies(String searchText) async {
    MovieResponse response = await _repository.getMoviesBySearch(searchText);
    _subject.sink.add(response);
  }

  Future<List<Movie>> fetchMovies(String searchText) async {
    MovieResponse response = await _repository.getMoviesBySearch(searchText);
    return response.movies;
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }
}

final BlocMoviesSearch blocMoviesSearch = BlocMoviesSearch();
