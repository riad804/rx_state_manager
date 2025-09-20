import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'rx_var.dart';

class ObRx extends StatelessWidget {
  final Widget Function() builder;
  final List<RxVar> listenTo;

  const ObRx({
    super.key,
    required this.builder,
    required this.listenTo,
  });

  @override
  Widget build(BuildContext context) {
    // Combine all RxVar streams into one
    final stream = Rx.combineLatest<dynamic, int>(
      listenTo.map((rx) => rx.stream), (_) => 0,
    );

    return StreamBuilder<int>(
      stream: stream,
      builder: (context, snapshot) {
        // snapshot is ignored; we rebuild when any emits
        return builder();
      },
    );
  }
}