import 'package:flutter/foundation.dart';
import 'package:themoviesapp/model/movie.dart';
import 'package:themoviesapp/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

class BlocMoviesTopRated {
  final Repository _repository = Repository();
  final ReplaySubject<MovieResponse> _subject = ReplaySubject<MovieResponse>();
  int pageNo = 1;

  ReplaySubject<MovieResponse> get subject => _subject;

  getMovies() async {
    MovieResponse response = await _repository.getMoviesTopRated(pageNo++);
    //_subject.sink.add(response);
    _subject.add(response);
  }

  Future<MovieResponse> getMoviesList() async {
    MovieResponse response = await _repository.getMoviesTopRated(pageNo++);
    return response;
  }

  void drainStream() {
    //_subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }
}

final BlocMoviesTopRated blocMoviesTopRated = BlocMoviesTopRated();
