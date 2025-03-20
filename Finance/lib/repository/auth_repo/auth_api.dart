import 'package:lane_dane/data/remote/network/network.api.service.dart';
import 'package:lane_dane/main.dart';

class AuthApi {
  final NetworkApiService _apiService = NetworkApiService();

  Future<Map<String, dynamic>> getOtp(String phone) async {
    final responseBody = await _apiService.post(
      "/api/verify-contact",
      query: {"phone_no": phone},
    );

    return responseBody;
  }

  Future<Map<String, dynamic>> login({
    required int phone,
    required String otp,
    required String? fcmToken,
  }) async {
    Map<String, dynamic> responseBody =
        await _apiService.post('/api/login', query: {
      'phone_no': phone.toString(),
      'otp': otp,
      'fcm_token': fcmToken,
    });
    // ApiService().addApiCallBack();
    talker.debug("@AuthApi : login() : Response -> $responseBody");
    // talker.info("@AuthApi : login() : ApiService Called");

    return responseBody;
  }

  Future<Map<String, dynamic>> register({
    required int phone,
    required String fullName,
    required String otp,
    required bool businessAccount,
    required String? fcmToken,
    required String email,
    required String pincode,
  }) async {
    Map<String, dynamic> responseBody = await _apiService.post(
      '/api/register',
      query: {
        'phone_no': phone.toString(),
        'full_name': fullName,
        'otp': otp,
        'email': email,
        'pincode': pincode,
        'business_account': businessAccount ? '1' : '0',
        'fcm_token': fcmToken!,
      },
    );
    // ApiService().addApiCallBack();
    // talker.info("@AuthApi : register() : ApiService Called");
    talker.debug("@AuthApi : register() : Response -> $responseBody");
    return responseBody;
  }
}
