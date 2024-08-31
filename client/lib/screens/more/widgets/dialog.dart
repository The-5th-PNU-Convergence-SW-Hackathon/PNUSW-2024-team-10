import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/theme/prefs.dart';

void showLanguageSelectorDialog(BuildContext context) async {
  final currentLocale = getLocale(context);

  if (context.mounted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LanguageSelectorDialog(initialLocale: currentLocale);
      },
    );
  }
}

void showThemeSelectorDialog(BuildContext context) async {
  final currentThemeMode = getThemeMode(context);

  if (context.mounted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ThemeSelectorDialog(initialTheme: currentThemeMode);
      },
    );
  }
}

class LanguageSelectorDialog extends StatefulWidget {
  final Locale? initialLocale;

  const LanguageSelectorDialog({
    super.key,
    this.initialLocale,
  });

  @override
  State<LanguageSelectorDialog> createState() => _LanguageSelectorDialogState();
}

class _LanguageSelectorDialogState extends State<LanguageSelectorDialog> {
  Locale? _selectedLocale;

  void _onLanguageSelected(BuildContext context, Locale? locale) {
    setLocale(context, locale);
  }

  @override
  void initState() {
    super.initState();
    _selectedLocale = widget.initialLocale;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      title: Text(l10n.morePreferencesLanguage),
      contentPadding: const EdgeInsets.all(10.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<Locale?>(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: Text(l10n.morePreferencesLanguageItem("system")),
            value: null,
            groupValue: _selectedLocale,
            onChanged: (Locale? value) {
              setState(() {
                _selectedLocale = value;
              });
            },
          ),
          RadioListTile<Locale>(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: Text(l10n.morePreferencesLanguageItem("ko")),
            value: const Locale('ko'),
            groupValue: _selectedLocale,
            onChanged: (Locale? value) {
              setState(() {
                _selectedLocale = value;
              });
            },
          ),
          RadioListTile<Locale>(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: Text(l10n.morePreferencesLanguageItem("en")),
            value: const Locale('en'),
            groupValue: _selectedLocale,
            onChanged: (Locale? value) {
              setState(() {
                _selectedLocale = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(l10n.commonConfirmationCancel),
        ),
        TextButton(
          onPressed: () {
            _onLanguageSelected(context, _selectedLocale);
            Navigator.pop(context);
          },
          child: Text(l10n.commonConfirmationApply),
        ),
      ],
    );
  }
}

class ThemeSelectorDialog extends StatefulWidget {
  final ThemeMode? initialTheme;

  const ThemeSelectorDialog({
    super.key,
    this.initialTheme,
  });

  @override
  State<ThemeSelectorDialog> createState() => _ThemeSelectorDialogState();
}

class _ThemeSelectorDialogState extends State<ThemeSelectorDialog> {
  late ThemeMode _selectedTheme;

  @override
  void initState() {
    super.initState();
    _selectedTheme = widget.initialTheme ?? ThemeMode.system;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      title: Text(l10n.morePreferencesTheme),
      contentPadding: const EdgeInsets.all(10.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<ThemeMode>(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: Text(l10n.morePreferencesThemeItem("other")),
            value: ThemeMode.system,
            groupValue: _selectedTheme,
            onChanged: (ThemeMode? mode) {
              setState(() {
                _selectedTheme = mode ?? ThemeMode.system;
              });
            },
          ),
          RadioListTile<ThemeMode>(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: Text(l10n.morePreferencesThemeItem("light")),
            value: ThemeMode.light,
            groupValue: _selectedTheme,
            onChanged: (ThemeMode? mode) {
              setState(() {
                _selectedTheme = mode ?? ThemeMode.system;
              });
            },
          ),
          RadioListTile<ThemeMode>(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: Text(l10n.morePreferencesThemeItem("dark")),
            value: ThemeMode.dark,
            groupValue: _selectedTheme,
            onChanged: (ThemeMode? mode) {
              setState(() {
                _selectedTheme = mode ?? ThemeMode.system;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(l10n.commonConfirmationCancel),
        ),
        TextButton(
          onPressed: () {
            setThemeMode(context, _selectedTheme);
            Navigator.pop(context);
          },
          child: Text(l10n.commonConfirmationApply),
        ),
      ],
    );
  }
}
