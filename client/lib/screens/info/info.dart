import 'package:heron/screens/info/webview.dart';
import 'package:flutter/material.dart';
import 'package:heron/widgets/appbar/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  double scrollOffset = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);

    return Scaffold(
      appBar: HeronAppBar(
        hasBackButton: false,
        scrollOffset: scrollOffset,
        largeTitle: true,
        title: Text(l10n.navigationLabelInfo),
        // actions: [
        //   HeronIconButton(
        //     onPressed: () {},
        //     icon: const Icon(HugeIcons.strokeRoundedFilterHorizontal),
        //   ),
        // ],
      ),
      body: InfoWebView(
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
