import 'package:flutter/foundation.dart';
import 'package:themoviesapp/model/movie.dart';
import 'package:themoviesapp/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

class BlocMoviesAll {
  final Repository _repository = Repository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  BehaviorSubject<MovieResponse> get subject => _subject;

  static MovieResponse defaultResponse;

  getMovies() async {
    MovieResponse response = await _repository.getMovies();
    defaultResponse = response;
    _subject.sink.add(response);
  }

  get DefaultResponse => defaultResponse;

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }
}

final BlocMoviesAll blocMoviesAll = BlocMoviesAll();