class NetworkTimeoutException implements Exception {
  final String message;
  NetworkTimeoutException([this.message = "This request took too long. Please ensure you have a stable internet connection and try again"]);
  @override
  String toString() => message;
}

class NetworkErrorException implements Exception {
  NetworkErrorException([String message = "No internet connection!"]);
}

class LocationPermissionsException implements Exception {
  final String message;
  LocationPermissionsException([this.message = "No location services were detected"]);
  @override
  String toString() => message;
}

class ErrorResponseException implements Exception {
  final String message;
  ErrorResponseException([this.message = "Something went wrong"]);
  @override
  String toString() => message;
}
