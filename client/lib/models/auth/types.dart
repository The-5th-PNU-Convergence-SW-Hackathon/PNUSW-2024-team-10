import 'package:heron/constants/request.dart';

enum UserProvider {
  google,
  apple,
}

class UserInfo {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final List<UserProvider> providers;

  const UserInfo({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.providers = const [],
  });
}

UserInfo? parseUserInfo(dynamic data, dynamic headers) {
  if (data is! Map<String, dynamic> ||
      headers is! Map<String, List<String>> ||
      data['id'] is! String ||
      data['name'] is! String ||
      data['email'] is! String ||
      data['avatar'] is! String? ||
      data['providers'] is! List) {
    return null;
  }

  return UserInfo(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      avatar: data['avatar'],
      providers: data['providers']
          .map<UserProvider?>((provider) {
            try {
              return UserProvider.values.firstWhere(
                (element) => element.toString() == provider,
              );
            } catch (e) {
              return null;
            }
          })
          .whereType<UserProvider>()
          .toList());
}

class Tokens {
  final String refreshToken;
  final String accessToken;

  const Tokens({
    required this.refreshToken,
    required this.accessToken,
  });
}

Tokens? parseTokens(dynamic data, dynamic headers) {
  if (data is! String ||
      headers is! Map<String, List<String>> ||
      headers[kHeaderNewToken]?.first is! String) {
    return null;
  }

  return Tokens(
    refreshToken: headers[kHeaderNewToken]!.first,
    accessToken: data,
  );
}
