import 'package:flutter/material.dart';
import 'package:heron/constants/webview.dart';
import 'package:heron/widgets/appbar/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/webview/webview.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  double scrollOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: HeronAppBar(
        title: Text(l10n.moreAppInfoTerms),
        scrollOffset: scrollOffset,
      ),
      body: TermsWebView(
        locale: locale,
        brightness: brightness,
        webViewBuilder: (controller) => controller
          ..setOnScrollPositionChange((pos) {
            if (mounted) {
              setState(() {
                scrollOffset = pos.y;
              });
            }
          }),
      ),
    );
  }
}

class TermsWebView extends InfoBaseWebView {
  const TermsWebView({
    super.key,
    super.webViewBuilder,
    required super.locale,
    required super.brightness,
  });

  @override
  String get baseUrl => "$kInfoBaseUrl/terms";

  @override
  NavigationDecision handleNavigationRequest(
    NavigationRequest request,
    BuildContext context,
  ) {
    if (!request.url.startsWith(baseUrl)) {
      launchUrlString(request.url);
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }
}
