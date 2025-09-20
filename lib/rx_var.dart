import 'dart:async';

import 'package:rxdart/rxdart.dart';

class RxVar<T> {
  final BehaviorSubject<T> _subject;

  RxVar([T? initial]) : _subject = BehaviorSubject<T>.seeded(initial as T);

  /// Current value
  T get value => _subject.value;

  /// Update value
  set value(T newValue) {
    _subject.add(newValue);
  }

  /// Stream for listening
  Stream<T> get stream => _subject.stream;

  bool get hasValue => _subject.hasValue;

  /// Close the stream
  void dispose() => _subject.close();
}
