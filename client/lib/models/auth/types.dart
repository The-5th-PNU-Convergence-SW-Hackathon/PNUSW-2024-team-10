import 'package:heron/constants/request.dart';
import 'package:heron/models/types.dart';

enum UserProvider {
  google,
  apple,
}

class UserInfo implements HeronResponse {
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

  @override
  factory UserInfo.fromJson(Map<String, dynamic> data) {
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
}

class Tokens {
  final String refreshToken;
  final String accessToken;

  const Tokens({
    required this.refreshToken,
    required this.accessToken,
  });

  factory Tokens.parse(String data, Map<String, List<String>> headers) {
    return Tokens(
      refreshToken: headers[kHeaderNewToken]!.first,
      accessToken: data,
    );
  }
}
