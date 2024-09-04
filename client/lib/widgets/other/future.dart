import 'package:flutter/material.dart';
import 'package:heron/widgets/theme/prefs.dart';

const kFetchFaderDuration = Duration(milliseconds: 240);

class HeronFutureBuilder<T> extends StatefulWidget {
  final Future<T> Function() future;
  final Widget Function(BuildContext, AsyncSnapshot<T>) builder;

  const HeronFutureBuilder({
    super.key,
    required this.future,
    required this.builder,
  });

  @override
  State<HeronFutureBuilder<T>> createState() => _HeronFutureBuilderState();
}

class _HeronFutureBuilderState<T> extends State<HeronFutureBuilder<T>> {
  late Future<T> _future;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Localizations.localeOf(context);
    getUser(context);
    _future = widget.future();
  }

  void _refetch() {
    setState(() {
      _future = widget.future();
    });
  }

  @override
  Widget build(BuildContext context) {
    return HeronFutureInheritedWidget(
      refetch: _refetch,
      child: FutureBuilder<T>(
        future: _future,
        builder: widget.builder,
      ),
    );
  }
}

class HeronFutureInheritedWidget extends InheritedWidget {
  final void Function() refetch;

  const HeronFutureInheritedWidget({
    super.key,
    required super.child,
    required this.refetch,
  });

  static HeronFutureInheritedWidget of(BuildContext context) {
    final HeronFutureInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<HeronFutureInheritedWidget>();
    assert(result != null, 'No HeronFutureInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(HeronFutureInheritedWidget oldWidget) {
    return oldWidget.key != key;
  }
}

void Function() getRefetch(BuildContext context) {
  return HeronFutureInheritedWidget.of(context).refetch;
}

class HeronFutureFader<T> extends StatelessWidget {
  final AsyncSnapshot<T> snapshot;
  final Widget Function(BuildContext, AsyncSnapshot<T>) builder;

  const HeronFutureFader({
    super.key,
    required this.snapshot,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedOpacity(
          opacity:
              snapshot.connectionState == ConnectionState.waiting ? 1.0 : 0.0,
          duration: kFetchFaderDuration,
          child: const Center(child: CircularProgressIndicator()),
        ),
        AnimatedOpacity(
          opacity: snapshot.connectionState == ConnectionState.done ? 1.0 : 0.0,
          duration: kFetchFaderDuration,
          child: snapshot.hasData
              ? builder(context, snapshot)
              : const Center(child: Text('Error')),
        ),
      ],
    );
  }
}
