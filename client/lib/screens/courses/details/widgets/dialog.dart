import 'package:flutter/material.dart';
import 'package:heron/widgets/button/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseStartDialog extends StatefulWidget {
  final Future<void> Function() onConfirm;

  const CourseStartDialog({super.key, required this.onConfirm});

  @override
  State<CourseStartDialog> createState() => _CourseStartDialogState();
}

class _CourseStartDialogState extends State<CourseStartDialog> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      title: Text(l10n.coursesDetailStart),
      content: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Text(l10n.coursesDetailStartMessage),
      ),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 1,
              child: HeronButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                variant: HeronButtonVariant.outline,
                child: Text(l10n.commonConfirmationCancel),
              ),
            ),
            const SizedBox(width: 10.0),
            Flexible(
              flex: 1,
              child: HeronButton(
                isLoading: _isLoading,
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  await widget.onConfirm();

                  setState(() {
                    _isLoading = false;
                  });

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: Text(l10n.commonConfirmationStart),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class CourseAbortDialog extends StatefulWidget {
  final Future<void> Function() onConfirm;

  const CourseAbortDialog({super.key, required this.onConfirm});

  @override
  State<CourseAbortDialog> createState() => _CourseAbortDialogState();
}

class _CourseAbortDialogState extends State<CourseAbortDialog> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      title: Text(l10n.coursesDetailAbort),
      content: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Text(l10n.coursesDetailAbortMessage),
      ),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 1,
              child: HeronButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                variant: HeronButtonVariant.outline,
                child: Text(l10n.commonConfirmationCancel),
              ),
            ),
            const SizedBox(width: 10.0),
            Flexible(
              flex: 1,
              child: HeronButton(
                color: Colors.redAccent,
                isLoading: _isLoading,
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  await widget.onConfirm();

                  setState(() {
                    _isLoading = false;
                  });

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: Text(l10n.commonConfirmationAbort),
              ),
            ),
          ],
        )
      ],
    );
  }
}