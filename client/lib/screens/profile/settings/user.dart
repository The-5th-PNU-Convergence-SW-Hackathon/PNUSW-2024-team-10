import 'package:heron/screens/profile/settings/language.dart';
import 'package:heron/screens/profile/settings/theme.dart';
import 'package:heron/widgets/list/items.dart';
import 'package:heron/widgets/list/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeronUserSettingsList extends StatelessWidget {
  const HeronUserSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return HeronListGroup(
      header: l10n.settingsUserLabel,
      children: [
        HeronNavigationListItem(
          onPressed: () async {
            // alert dialog
            showLanguageSelectorDialog(context);
          },
          child: Text(l10n.settingsUserLanguage),
        ),
        HeronNavigationListItem(
          onPressed: () async {
            // alert dialog
            showThemeSelectorDialog(context);
          },
          child: Text(l10n.settingsUserTheme),
        ),
        HeronPressableListItem(
          onPressed: () {
            // alert dialog
          },
          child: Text(
            l10n.settingsUserSignOut,
            style: const TextStyle(color: Colors.redAccent),
          ),
        )
      ],
    );
  }
}
