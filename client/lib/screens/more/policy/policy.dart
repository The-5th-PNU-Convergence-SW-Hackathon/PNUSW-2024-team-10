import 'package:flutter/material.dart';
import 'package:heron/constants/webview.dart';
import 'package:heron/widgets/appbar/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/webview/webview.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  double scrollOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: HeronAppBar(
        title: Text(l10n.moreAppInfoPrivacy),
        scrollOffset: scrollOffset,
      ),
      body: PrivacyWebView(
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

class PrivacyWebView extends InfoBaseWebView {
  const PrivacyWebView({
    super.key,
    super.webViewBuilder,
    required super.locale,
    required super.brightness,
  });

  @override
  String get baseUrl => "$kInfoBaseUrl/privacy";

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
