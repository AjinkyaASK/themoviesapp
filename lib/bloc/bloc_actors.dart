import 'package:flutter/foundation.dart';
import 'package:themoviesapp/model/actor.dart';
import 'package:themoviesapp/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

class BlocActors {
  final Repository _repository = Repository();
  final BehaviorSubject<ActorResponse> _subject =
      BehaviorSubject<ActorResponse>();

  BehaviorSubject<ActorResponse> get subject => _subject;

  getActors() async {
    ActorResponse response = await _repository.getActors();
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

final BlocActors blocActors = BlocActors();
