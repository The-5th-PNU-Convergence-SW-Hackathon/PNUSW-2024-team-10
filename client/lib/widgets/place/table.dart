import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hugeicons/hugeicons.dart';

class HeronPlaceSheetDataTable extends StatelessWidget {
  final String address;
  final String? menu;

  const HeronPlaceSheetDataTable({
    super.key,
    required this.address,
    this.menu,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: address));
              Fluttertoast.showToast(
                msg: l10n.placeCopiedMessage,
                backgroundColor: colorScheme.inverseSurface,
                textColor: colorScheme.onInverseSurface,
              );
            },
            child: _HeronPlaceSheetDataItem(
                icon: HugeIcons.strokeRoundedLocation01,
                child: SizedBox(
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$address  ", style: textTheme.bodyLarge),
                        WidgetSpan(
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedCopy01,
                            color: colorScheme.outline,
                            size: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          if (menu != null) ...[
            const SizedBox(height: 4.0),
            _HeronPlaceSheetDataItem(
              icon: HugeIcons.strokeRoundedMenuRestaurant,
              child: Text(menu!),
            ),
          ],
        ],
      ),
    );
  }
}

class _HeronPlaceSheetDataItem extends StatelessWidget {
  final IconData icon;
  final Widget child;

  const _HeronPlaceSheetDataItem({
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: HugeIcon(icon: icon, color: colorScheme.primary, size: 18.0),
        ),
        const SizedBox(width: 8.0),
        DefaultTextStyle(
            style: textTheme.bodyLarge!, child: Expanded(child: child)),
      ],
    );
  }
}
