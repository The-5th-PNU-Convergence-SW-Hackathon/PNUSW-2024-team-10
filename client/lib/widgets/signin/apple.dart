import 'package:flutter/material.dart';
import 'package:heron/models/auth/apple.dart';
import 'package:heron/widgets/button/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/theme/prefs.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInButton extends StatefulWidget {
  const AppleSignInButton({super.key});

  @override
  State<AppleSignInButton> createState() => _AppleSignInButtonState();
}

class _AppleSignInButtonState extends State<AppleSignInButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return HeronButton(
      variant: HeronButtonVariant.outline,
      isLoading: _isLoading,
      onPressed: () async {
        setState(() {
          _isLoading = true;
        });
        try {
          final credential = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );

          if (credential.identityToken == null) {
            setState(() {
              _isLoading = false;
            });
            return;
          }

          final result = await apiAuthAppleGet(
            identityToken: credential.identityToken!,
            firstName: credential.givenName,
            lastName: credential.familyName,
          );

          if (result == true && context.mounted) {
            updateUser(context);
            Navigator.of(context).pop();
            return;
          }
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 3.0),
            child: Text("", style: TextStyle(fontSize: 21.0)),
          ),
          const SizedBox(width: 8.0),
          Text(l10n.signInWithApple),
        ],
      ),
    );
  }
}
