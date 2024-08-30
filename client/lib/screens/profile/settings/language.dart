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
      title: Text(l10n.settingsUserLanguage),
      contentPadding: const EdgeInsets.all(10.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<Locale?>(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: Text(l10n.settingsUserLanguageSystem),
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
            title: Text(l10n.settingsUserLanguageKorean),
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
            title: Text(l10n.settingsUserLanguageEnglish),
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
