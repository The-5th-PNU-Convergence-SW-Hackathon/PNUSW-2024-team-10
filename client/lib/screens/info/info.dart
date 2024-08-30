import 'dart:convert';
import 'dart:developer';

import 'package:heron/constants/webview.dart';
import 'package:heron/models/info/types.dart';
import 'package:heron/screens/info/filter.dart';
import 'package:heron/screens/info/webview.dart';
import 'package:flutter/material.dart';
import 'package:heron/widgets/appbar/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/button/icon.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:go_router/go_router.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  double scrollOffset = 0;
  List<HeronInfoFilter> filters = [];
  late WebViewController controller = WebViewController();

  List<HeronInfoFilterOption> _filterOptionParser(List list) {
    List<HeronInfoFilterOption> options = [];

    try {
      for (final option in list) {
        if (option['id'] is! String || option['value'] is! String) {
          return [];
        }

        if (option['selected'] is! bool) {
          option['selected'] = true;
        } else {
          option['selected'] = option['selected'] as bool;
        }

        options.add(HeronInfoFilterOption(
          id: option['id'],
          value: option['value'],
          selected: option['selected'],
        ));
      }

      return options;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  void _filterParser(JavaScriptMessage javascriptMessage) {
    try {
      List<HeronInfoFilter> tempFilters = [];
      final Map<String, dynamic> filter = jsonDecode(javascriptMessage.message);

      filter.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          if (value['name'] is! String || value['options'] is! List) {
            return;
          }

          tempFilters.add(HeronInfoFilter(
            id: key,
            name: value['name'],
            options: _filterOptionParser(value['options']),
          ));
        }
      });

      setState(() {
        filters = tempFilters;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: HeronAppBar(
        hasBackButton: false,
        scrollOffset: scrollOffset,
        largeTitle: true,
        title: Text(l10n.navigationLabelInfo),
        actions: [
          if (filters.isNotEmpty)
            HeronIconButton(
              onPressed: () {
                showInfoFilterSheet(
                  context: context,
                  onApply: (newFilters) {
                    final newUrl = Uri.parse(kInfoBaseUrl).replace(
                      queryParameters: {
                        for (final filter in newFilters)
                          filter.id: filter.options
                              .where((option) => option.selected)
                              .map((option) => option.value)
                              .join(","),
                      },
                    );
                    controller.loadRequest(newUrl, headers: {
                      "Accept-Language": locale.languageCode,
                      kHeronBrightnessKey: brightness.name,
                    });
                  },
                  initialFilters: filters,
                );
              },
              icon: const Icon(HugeIcons.strokeRoundedFilterHorizontal),
            ),
        ],
      ),
      body: InfoWebView(
        locale: locale,
        brightness: brightness,
        webViewBuilder: (_) => controller
          ..setOnScrollPositionChange(
            (pos) {
              setState(() {
                scrollOffset = pos.y;
              });
            },
          )
          ..addJavaScriptChannel(
            kFilterChannelName,
            onMessageReceived: _filterParser,
          ),
      ),
    );
  }
}

class InfoWebView extends InfoBaseWebView {
  const InfoWebView({
    super.key,
    super.webViewBuilder,
    required super.locale,
    required super.brightness,
  });

  @override
  String get baseUrl => kInfoBaseUrl;

  @override
  NavigationDecision handleNavigationRequest(
      NavigationRequest request, BuildContext context) {
    final url = request.url;
    if (!url.startsWith(baseUrl)) {
      return NavigationDecision.prevent;
    }

    final id =
        url.substring(kInfoBaseUrl.length + 1).split("?")[0].split("/")[0];

    if (id.isNotEmpty) {
      context.go("/info/$id");
      return NavigationDecision.prevent;
    }

    return NavigationDecision.navigate;
  }
}
