import 'package:heron/widgets/list/items.dart';
import 'package:heron/widgets/list/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:go_router/go_router.dart';

const String _repositoryUrl =
    "https://github.com/pnusw-hackathon/PNUSW-2024-team-10";

class MoreAppInfoList extends StatefulWidget {
  const MoreAppInfoList({super.key});

  @override
  State<MoreAppInfoList> createState() => _MoreAppInfoListState();
}

class _MoreAppInfoListState extends State<MoreAppInfoList> {
  PackageInfo packageInfo = PackageInfo(
    appName: '-',
    packageName: '-',
    version: '-',
    buildNumber: '-',
    buildSignature: '-',
    installerStore: '-',
  );

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((value) {
      setState(() {
        packageInfo = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return HeronListGroup(
      header: l10n.moreAppInfoLabel,
      children: [
        HeronListItem(
          child: Row(
            children: [
              Text(l10n.moreAppInfoVersion),
              const Spacer(),
              Text(
                packageInfo.version,
                style: TextStyle(
                  color: colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
        HeronNavigationListItem(
          onPressed: () {
            context.go("/more/terms");
          },
          child: Text(l10n.moreAppInfoTerms),
        ),
        HeronNavigationListItem(
          onPressed: () {
            context.go("/more/privacy");
          },
          child: Text(l10n.moreAppInfoPrivacy),
        ),
        HeronNavigationListItem(
          onPressed: () {
            showLicensePage(context: context);
          },
          child: Text(l10n.moreAppInfoLicenses),
        ),
        HeronPressableListItem(
          onPressed: () {
            launchUrlString(
              _repositoryUrl,
              mode: LaunchMode.externalApplication,
            );
          },
          child: Text(
            l10n.moreAppInfoRepository,
            style: const TextStyle(color: Colors.blueAccent),
          ),
        )
      ],
    );
  }
}
