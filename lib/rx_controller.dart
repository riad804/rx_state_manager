import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'rx_var.dart';

/// Base controller like GetxController but uses rxdart
abstract class RxController {
  final List<StreamSubscription> _subscriptions = [];

  /// Called when controller is allocated
  void onInit() {}

  /// Called before controller is destroyed
  void onClose() {}

  /// Register a subscription for auto-dispose
  void addWorker(StreamSubscription sub) => _subscriptions.add(sub);

  /// Dispose workers & streams
  void dispose() {
    for (final s in _subscriptions) {
      s.cancel();
    }
    onClose();
  }

  /// Worker helpers (auto-dispose)
  void ever<T>(RxVar<T> rx, void Function(T?) worker) {
    addWorker(rx.stream.skip(1).listen(worker));
  }

  void debounce<T>(
    RxVar<T> rx,
    void Function(T) worker, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    addWorker(rx.stream.debounceTime(duration).listen(worker));
  }

  void everAll(List<RxVar> list, void Function(List values) worker) {
    void trigger() => worker(list.map((e) => e.value).toList());
    for (final rx in list) {
      addWorker(rx.stream.skip(1).listen((_) => trigger()));
    }
  }

  void interval<T>(
    RxVar<T> rx,
    void Function(T) worker, {
    Duration duration = const Duration(milliseconds: 500),
    bool leading = true,
  }) {
    // rxdart's debounceTime emits the *last* event after the duration has passed since the last event
    Stream<T> s = rx.stream.debounceTime(duration);

    // If leading is true, emit first value immediately and then throttle
    if (leading && rx.hasValue) {
      worker(rx.value);
    }

    addWorker(s.skip(1).listen(worker));
  }
}
