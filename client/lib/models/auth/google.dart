import 'package:heron/models/auth/types.dart';
import 'package:heron/utilities/auth.dart';

Future<bool> apiAuthGoogleGet(String accessToken) async {
  final dio = await getDio();

  final response = await dio.post(
    "/auth/google",
    data: {
      'accessToken': accessToken,
    },
  );

  if (response.statusCode != 200) {
    return false;
  }

  final data = response.data;
  final headers = response.headers.map;

  final tokens = Tokens.parse(data, headers);
  await saveTokens(tokens.accessToken, tokens.refreshToken);
  return true;
}
