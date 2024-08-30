import 'package:flutter/material.dart';
import 'package:heron/constants/webview.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InfoDetailsWebView extends StatefulWidget {
  final String id;
  final void Function(double)? onScroll;
  final Locale locale;

  const InfoDetailsWebView({
    super.key,
    required this.id,
    this.onScroll,
    required this.locale,
  });

  @override
  State<InfoDetailsWebView> createState() => _InfoDetailsWebViewState();
}

class _InfoDetailsWebViewState extends State<InfoDetailsWebView> {
  WebViewController? controller;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();

    final baseUrl = "$kInfoBaseUrl/${widget.id}";

    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        controller = WebViewController()
          ..setUserAgent(
              "${packageInfo.appName}/${packageInfo.version} (${packageInfo.packageName})")
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(Colors.transparent)
          ..setNavigationDelegate(
            NavigationDelegate(
              onNavigationRequest: (request) {
                if (!request.url.startsWith(baseUrl)) {
                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
              onPageFinished: (url) {
                controller?.runJavaScript(_defaultScript);
                setState(() {
                  isVisible = true;
                });
              },
            ),
          )
          ..setOnScrollPositionChange((position) {
            widget.onScroll?.call(position.y);
          })
          ..loadRequest(Uri.parse(baseUrl), headers: {
            "Accept-Language": widget.locale.languageCode,
          });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: kWebViewLoadDuration,
          child: controller != null
              ? WebViewWidget(controller: controller!)
              : null,
        ),
        AnimatedOpacity(
          opacity: isVisible ? 0.0 : 1.0,
          duration: kWebViewLoadDuration,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}

const _defaultScript = """
document.body.style["-webkit-touch-callout"] = "none";
""";
