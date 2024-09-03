import 'package:flutter/material.dart';

const kFetchFaderDuration = Duration(milliseconds: 240);

class HeronFutureFader<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext, AsyncSnapshot<T>) builder;

  const HeronFutureFader({
    super.key,
    required this.future,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) => Stack(
        children: [
          AnimatedOpacity(
            opacity:
                snapshot.connectionState == ConnectionState.waiting ? 1.0 : 0.0,
            duration: kFetchFaderDuration,
            child: const Center(child: CircularProgressIndicator()),
          ),
          AnimatedOpacity(
            opacity:
                snapshot.connectionState == ConnectionState.done ? 1.0 : 0.0,
            duration: kFetchFaderDuration,
            child: snapshot.hasData
                ? builder(context, snapshot)
                : const Center(child: Text('Error')),
          ),
        ],
      ),
    );
  }
}
