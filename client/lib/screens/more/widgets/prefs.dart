import 'package:heron/screens/more/widgets/dialog.dart';
import 'package:heron/widgets/list/items.dart';
import 'package:heron/widgets/list/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/theme/prefs.dart';

class MoreUserSettingsList extends StatelessWidget {
  const MoreUserSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    final themeMode = getThemeMode(context);
    final locale = getLocale(context);

    return HeronListGroup(
      header: l10n.morePreferencesLabel,
      children: [
        HeronNavigationListItem(
          onPressed: () async {
            // alert dialog
            showLanguageSelectorDialog(context);
          },
          child: Row(
            children: [
              Text(l10n.morePreferencesLanguage),
              const Spacer(),
              Text(
                l10n.morePreferencesLanguageItem(
                    locale?.languageCode ?? "other"),
                style: TextStyle(
                  color: colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
        HeronNavigationListItem(
          onPressed: () async {
            // alert dialog
            showThemeSelectorDialog(context);
          },
          child: Row(
            children: [
              Text(l10n.morePreferencesTheme),
              const Spacer(),
              Text(
                l10n.morePreferencesThemeItem(themeMode.toString()),
                style: TextStyle(
                  color: colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
