abstract class HeronResponse {
  const HeronResponse();

  // should be implemented in subclasses
  factory HeronResponse.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}