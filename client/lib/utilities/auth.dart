import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:heron/constants/request.dart';
import 'package:heron/utilities/device_id.dart';
import 'package:heron/widgets/theme/prefs.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';

const secureStorage = FlutterSecureStorage();

Future<Dio> getDioWithAccessToken(BuildContext? context) async {
  final dio = await getDio();

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // Get access token from secure storage
      String? accessToken = await secureStorage.read(key: kAccessTokenKey);
      if (accessToken != null) {
        options.headers['Authorization'] = '$kBearer $accessToken';
      }
      handler.next(options);
    },
    onResponse: (response, handler) async {
      // Check for new token in response headers and update secure storage
      if (response.headers[kHeaderNewToken] != null) {
        String newToken = response.headers[kHeaderNewToken]!.first;
        await secureStorage.write(key: kAccessTokenKey, value: newToken);
      }
      handler.next(response);
    },
    onError: (DioException e, handler) async {
      // Handle 401 Unauthorized by refreshing the token
      if (e.response?.statusCode == 401) {
        final refreshToken = await secureStorage.read(key: kRefreshTokenKey);
        if (refreshToken != null) {
          try {
            final newToken = await refreshAccessToken();
            if (newToken != null) {
              await secureStorage.write(key: kAccessTokenKey, value: newToken);

              // Retry the failed request with the new access token
              e.requestOptions.headers['Authorization'] = '$kBearer $newToken';
              final cloneReq = await dio.request(
                e.requestOptions.path,
                options: Options(
                  method: e.requestOptions.method,
                  headers: e.requestOptions.headers,
                ),
                data: e.requestOptions.data,
                queryParameters: e.requestOptions.queryParameters,
              );

              return handler.resolve(cloneReq);
            }
          } catch (err) {
            // Handle refresh token failure (e.g., logout the user)
            await handleLogout(
              context != null && context.mounted ? context : null,
            );
          }
        }
      }
      handler.next(e);
    },
  ));

  return dio;
}

Future<Dio> getDio() async {
  final deviceId = await getDeviceId();
  final packageInfo = await PackageInfo.fromPlatform();

  final options = BaseOptions(
    baseUrl: kApiBaseURL,
    headers: {
      'Content-Type': 'application/json',
      'User-Agent':
          '${packageInfo.appName}/${packageInfo.version} (${packageInfo.packageName}; ${Platform.operatingSystem})',
      'Device-Id': deviceId,
    },
  );

  return Dio(options);
}

Future saveTokens(String? accessToken, String? refreshToken) async {
  if (accessToken != null) {
    await secureStorage.write(key: kAccessTokenKey, value: accessToken);
  }

  if (refreshToken != null) {
    await secureStorage.write(key: kRefreshTokenKey, value: refreshToken);
  }
}

Future<String?> refreshAccessToken() async {
  final dio = await getDio();
  final refreshToken = await secureStorage.read(key: kRefreshTokenKey);

  try {
    final response = await dio.get(
      '/auth',
      options: Options(headers: {
        'Authorization': '$kBearer $refreshToken',
      }),
    );

    if (response.statusCode == 200) {
      return response.data[kAccessTokenKey];
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<void> handleLogout(BuildContext? context) async {
  secureStorage.deleteAll();
  if (context != null && context.mounted) {
    clearUser(context);
  }
}
