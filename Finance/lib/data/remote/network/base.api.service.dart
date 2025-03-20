abstract class BaseApiService {
  static const String kBaseUrl = "lane-dane.com";

  /// Make this false when running on a local server. Otherwise true when running
  /// on main server.
  static bool get defaultToHttps {
    if (kBaseUrl == 'lane-dane.com') {
      return true;
    } else {
      return false;
    }
    // return false;
  }

  Future<dynamic> getResponse(String url);
  Future<dynamic> postResponse(String url, Map<String, String> jsonBody);
}
