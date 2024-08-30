import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/theme/prefs.dart';

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
  ThemeMode? _selectedTheme;


  @override
  void initState() {
    super.initState();
    _selectedTheme = widget.initialTheme;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surfaceBright,
      title: Text(l10n.settingsUserTheme),
      contentPadding: const EdgeInsets.all(10.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<ThemeMode?>(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: Text(l10n.settingsUserThemeSystem),
            value: null,
            groupValue: _selectedTheme,
            onChanged: (ThemeMode? mode) {
              setState(() {
                _selectedTheme = mode;
              });
            },
          ),
          RadioListTile<ThemeMode>(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: Text(l10n.settingsUserThemeLight),
            value: ThemeMode.light,
            groupValue: _selectedTheme,
            onChanged: (ThemeMode? mode) {
              setState(() {
                _selectedTheme = mode;
              });
            },
          ),
          RadioListTile<ThemeMode>(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: Text(l10n.settingsUserThemeDark),
            value: ThemeMode.dark,
            groupValue: _selectedTheme,
            onChanged: (ThemeMode? mode) {
              setState(() {
                _selectedTheme = mode;
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
