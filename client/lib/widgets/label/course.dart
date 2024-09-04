import 'package:flutter/material.dart';
import 'package:heron/widgets/label/label.dart';
import 'package:heron/models/courses/types.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeronCourseStatusLabel extends HeronLabel {
  final HeronCourseStateLabelType type;

  const HeronCourseStatusLabel(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return HeronLabel(
      color: type.color,
      child: Text(type.getDisplayText(l10n).toUpperCase()),
    );
  }
}
