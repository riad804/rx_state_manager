import 'package:flutter_test/flutter_test.dart';
import 'package:rx_state_manager/rx_state_manager.dart';

class TestController extends RxController {
  final count = RxVar<int>(0);
  int everCalled = 0;
  int debounceCalled = 0;
  int intervalCalled = 0;
  int everAllCalled = 0;

  void inc() => count.value++;
}

void main() {
  group('RxController', () {
    late TestController controller;

    setUp(() {
      controller = TestController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('ever triggers on every change', () async {
      int called = 0;
      controller.ever(controller.count, (v) => called++);
      controller.inc();
      controller.inc();
      await Future.delayed(Duration(milliseconds: 10));
      expect(called, 2);
    });

    test('debounce triggers after delay', () async {
      int called = 0;
      controller.debounce(
        controller.count,
        (v) => called++,
        duration: Duration(milliseconds: 100),
      );
      controller.inc();
      controller.inc();
      await Future.delayed(Duration(milliseconds: 150));
      expect(called, 1);
    });

    test('interval triggers after interval', () async {
      int called = 0;
      controller.interval(
        controller.count,
        (v) => called++,
        duration: Duration(milliseconds: 100),
      );
      controller.inc();
      controller.inc();
      await Future.delayed(Duration(milliseconds: 150));
      expect(called, 1);
    });

    test('everAll triggers on any change', () async {
      final other = RxVar<int>(0);
      int called = 0;
      controller.everAll([controller.count, other], (values) => called++);
      controller.inc();
      other.value++;
      await Future.delayed(Duration(milliseconds: 10));
      expect(called, 2);
    });

    test('dispose cancels subscriptions', () async {
      int called = 0;
      controller.ever(controller.count, (v) => called++);
      controller.dispose();
      controller.inc();
      await Future.delayed(Duration(milliseconds: 10));
      expect(called, 0);
    });
  });
}
