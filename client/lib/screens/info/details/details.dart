import 'package:flutter/material.dart';
import 'package:heron/constants/webview.dart';
import 'package:heron/screens/info/details/webview.dart';
import 'package:heron/widgets/appbar/appbar.dart';
import 'package:heron/widgets/button/icon.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:share_plus/share_plus.dart';

class InfoDetailsScreen extends StatefulWidget {
  final String id;

  const InfoDetailsScreen(this.id, {super.key});

  @override
  State<InfoDetailsScreen> createState() => _InfoDetailsScreenState();
}

class _InfoDetailsScreenState extends State<InfoDetailsScreen> {
  double scrollOffset = 0;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    return Scaffold(
      appBar: HeronAppBar(
          scrollOffset: scrollOffset,
          hideTitleOnTop: true,
          title: const Text('Info'),
          actions: [
            HeronIconButton(
              icon: const Icon(HugeIcons.strokeRoundedShare05),
              onPressed: () {
                Share.shareUri(Uri.parse("$kInfoBaseUrl/${widget.id}"));
              },
            ),
          ]),
      body: InfoDetailsWebView(
        id: widget.id,
        locale: locale,
        onScroll: (offset) {
          setState(() {
            scrollOffset = offset;
          });
        },
      ),
    );
  }
}
