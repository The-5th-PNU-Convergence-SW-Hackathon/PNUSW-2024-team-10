import 'package:heron/models/auth/types.dart';
import 'package:heron/utilities/auth.dart';

Future<bool> apiAuthAppleGet({
  required String identityToken,
  String? firstName,
  String? lastName,
}) async {
  final dio = await getDio();

  final response = await dio.post(
    "/auth/apple",
    data: {
      'identityToken': identityToken,
      'firstName': firstName,
      'lastName': lastName,
    },
  );

  if (response.statusCode != 200) {
    return false;
  }

  final data = response.data;
  final headers = response.headers.map;

  final tokens = parseTokens(data, headers);
  if (tokens == null) {
    return false;
  }

  await saveTokens(tokens.accessToken, tokens.refreshToken);
  return true;
}
