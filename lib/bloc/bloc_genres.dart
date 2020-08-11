import 'package:flutter/foundation.dart';
import 'package:themoviesapp/model/genre.dart';
import 'package:themoviesapp/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

class BlocGenres {
  final Repository _repository = Repository();
  final BehaviorSubject<GenreResponse> _subject =
      BehaviorSubject<GenreResponse>();

  BehaviorSubject<GenreResponse> get subject => _subject;

  getGenres() async {
    GenreResponse response = await _repository.getGenres();
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

final BlocGenres blocGenres = BlocGenres();
