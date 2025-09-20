import 'package:rx_state_manager/rx_state_manager.dart';

class ObRx extends StatelessWidget {
  final Widget Function() builder;
  final List<dynamic> listenTo;

  const ObRx({super.key, required this.builder, required this.listenTo});

  @override
  Widget build(BuildContext context) {
    final streams = listenTo.map<Stream<dynamic>>((item) {
      if (item is RxVar) return item.stream;
      if (item is RxState) return item.stream;
      throw Exception("ObRx only supports RxVar or RxState");
    }).toList();

    final combinedStream = Rx.combineLatest<dynamic, int>(
      streams,
      (_) => 0,
    );

    return StreamBuilder<int>(
      stream: combinedStream,
      builder: (context, snapshot) {
        return builder();
      },
    );
  }
}
