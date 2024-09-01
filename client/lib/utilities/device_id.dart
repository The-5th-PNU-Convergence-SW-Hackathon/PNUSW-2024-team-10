import 'package:app_set_id/app_set_id.dart';

Future<String> getDeviceId() async {
  final deviceId = await AppSetId().getIdentifier();

  if (deviceId == null) {
    throw Exception('Failed to get device id');
  }

  return deviceId;
}
