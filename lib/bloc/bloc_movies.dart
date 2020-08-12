import 'package:flutter/foundation.dart';
import 'package:themoviesapp/model/movie.dart';
import 'package:themoviesapp/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

class BlocMovies {
  final Repository _repository = Repository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();
  int genreid;

  BehaviorSubject<MovieResponse> get subject => _subject;

  getMovies({
    MoviesDataType requestType,
    int genreID = 0,
    String searchQuery = '',
    int pageNo,
  }) async {
    MovieResponse response = await _repository.getMovies2(requestType);
    _subject.sink.add(response);
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

final BlocMovies blocMoviesAll = BlocMovies();
