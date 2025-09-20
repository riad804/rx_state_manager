# rx_dartx
A reactive system using `rxdart` with RxVar, RxController and ObRx.

## Usage

#### 1. Create reactive variables
```dart
import 'package:rx_state/rx_state.dart';

final count = RxVar<int>(0);
```


#### 2. Use a controller
```dart
class CounterController extends RxController {
  final count = RxVar<int>(0);

  void increment() => count.value++;
}
```

#### 3. Bind to UI with ObRx
```dart
controller.ever(controller.count, (value) {
  print('Count changed: $value');
});
```


#### 4. Bind to UI with ObRx
```dart
controller.ever(controller.count, (value) {
  print('Count changed: $value');
});
```

### Example

```dart
import 'package:flutter/material.dart';
import 'package:rx_state/rx_state.dart';

class CounterController extends RxController {
  final count = RxVar<int>(0);

  void increment() => count.value++;
}

final controller = CounterController();

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ObRx(
            listenTo: [controller.count],
            builder: () => Text('Count: ${controller.count.value}'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.increment,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}