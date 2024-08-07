import 'package:flutter/material.dart';
import 'package:heron_app/constants/theme/typography.dart';
import 'package:heron_app/widgets/common/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String _notionUrl =
    "https://futuristic-budget-d22.notion.site/ce0ed34714004a97b8156d5d824c8160?v=11eb5d1ffec14b5c8f961cd0613b0ceb&pvs=4";

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final _webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(_notionUrl));

  @override
  Widget build(BuildContext context) {
    final typography = getTypography(context);

    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            color: Colors.white,
            child: WebViewWidget(
              controller: _webViewController,
            )));
  }
}
