import 'package:flutter/material.dart';
import 'package:heron/constants/webview.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:go_router/go_router.dart';

class InfoWebView extends StatefulWidget {
  final void Function(double)? onScroll;
  final Locale locale;

  const InfoWebView({super.key, this.onScroll, required this.locale});

  @override
  State<InfoWebView> createState() => _InfoWebViewState();
}

class _InfoWebViewState extends State<InfoWebView> {
  WebViewController? controller;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();

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
                final url = request.url;
                if (!url.startsWith(kInfoBaseUrl)) {
                  return NavigationDecision.prevent;
                }

                final id = url
                    .substring(kInfoBaseUrl.length + 1)
                    .split("?")[0]
                    .split("/")[0];

                if (id.isNotEmpty) {
                  context.go("/info/$id");
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
          ..loadRequest(Uri.parse(kInfoBaseUrl), headers: {
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
