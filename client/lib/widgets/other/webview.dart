import 'package:flutter/material.dart';
import 'package:heron/constants/webview.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

abstract class InfoBaseWebView extends StatefulWidget {
  final Locale locale;
  final Brightness brightness;
  final WebViewController Function(WebViewController) webViewBuilder;

  const InfoBaseWebView({
    super.key,
    required this.locale,
    required this.brightness,
    this.webViewBuilder = _defaultWebViewBuilder,
  });

  @override
  State<InfoBaseWebView> createState() => _InfoBaseWebViewState();

  String get baseUrl;

  NavigationDecision handleNavigationRequest(
      NavigationRequest request, BuildContext context);
}

class _InfoBaseWebViewState extends State<InfoBaseWebView> {
  WebViewController? controller;
  bool isVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    final brightness = Theme.of(context).brightness;

    controller?.loadRequest(Uri.parse(widget.baseUrl), headers: {
      "Accept-Language": locale.languageCode,
      kHeronBrightnessKey: brightness.name,
    });
  }

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((packageInfo) {
      if (mounted) {
        setState(() {
          controller = widget.webViewBuilder(WebViewController())
            ..setUserAgent(
                "${packageInfo.appName}/${packageInfo.version} (${packageInfo.packageName})")
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(Colors.transparent)
            ..setNavigationDelegate(
              NavigationDelegate(
                onNavigationRequest: (request) {
                  final decision =
                      widget.handleNavigationRequest(request, context);
                  if (decision == NavigationDecision.navigate) {
                    if (mounted) {
                      setState(() {
                        isVisible = false;
                      });
                    }
                  }

                  return decision;
                },
                onPageFinished: (url) {
                  if (mounted) {
                    controller?.runJavaScript(_defaultScript);
                    setState(() {
                      isVisible = true;
                    });
                  }
                },
              ),
            )
            ..loadRequest(Uri.parse(widget.baseUrl), headers: {
              "Accept-Language": widget.locale.languageCode,
              kHeronBrightnessKey: widget.brightness.name,
            });
        });
      }
    });
  }

  @override
  void dispose() {
    controller = null;
    super.dispose();
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

WebViewController _defaultWebViewBuilder(WebViewController controller) {
  return controller;
}

const _defaultScript = """
document.body.style["-webkit-touch-callout"] = "none";
""";
