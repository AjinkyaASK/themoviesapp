import 'package:flutter/foundation.dart';
import 'package:themoviesapp/model/movie.dart';
import 'package:themoviesapp/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

class BlocMoviesNowPlaying {
  final Repository _repository = Repository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  BehaviorSubject<MovieResponse> get subject => _subject;

  getMovies() async {
    MovieResponse response = await _repository.getMoviesNowPlaying();
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

final BlocMoviesNowPlaying blocMoviesNowPlaying = BlocMoviesNowPlaying();
