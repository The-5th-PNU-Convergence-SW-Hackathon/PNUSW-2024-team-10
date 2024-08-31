import 'package:flutter/material.dart';
import 'package:heron/constants/webview.dart';
import 'package:heron/screens/info/widgets/webview.dart';
import 'package:heron/widgets/appbar/appbar.dart';
import 'package:heron/widgets/button/icon.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final brightness = Theme.of(context).brightness;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: HeronAppBar(
          scrollOffset: scrollOffset,
          hideTitleOnTop: true,
          title: Text(l10n.infoArticleTitle),
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
        brightness: brightness,
        webViewBuilder: (controller) => controller
          ..setOnScrollPositionChange(
            (pos) {
              setState(() {
                scrollOffset = pos.y;
              });
            },
          ),
      ),
    );
  }
}

class InfoDetailsWebView extends InfoBaseWebView {
  final String id;

  const InfoDetailsWebView({
    super.key,
    super.webViewBuilder,
    required this.id,
    required super.locale,
    required super.brightness,
  });

  @override
  String get baseUrl => "$kInfoBaseUrl/$id";

  @override
  NavigationDecision handleNavigationRequest(
      NavigationRequest request, BuildContext context) {
    if (!request.url.startsWith(baseUrl)) {
      launchUrlString(request.url);
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }
}
