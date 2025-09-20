import 'package:rx_state_manager/rx_state_manager.dart';

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


class RxState<T> {
  final BehaviorSubject<RxStateBase<T>> _subject;

  RxState([RxStateBase<T>? initial])
      : _subject = BehaviorSubject<RxStateBase<T>>.seeded(initial ?? const RxIdle());

  RxStateBase<T> get value => _subject.value;

  set value(RxStateBase<T> newState) => _subject.add(newState);

  Stream<RxStateBase<T>> get stream => _subject.stream;

  void dispose() => _subject.close();
}