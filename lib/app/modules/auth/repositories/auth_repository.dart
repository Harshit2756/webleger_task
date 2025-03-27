import 'package:get/get.dart';

import '../../../../core/utils/helpers/logger.dart';
import '../../../data/models/network/user_model.dart';
import '../../../data/models/response_model.dart';
import '../../../data/providers/local_db/storage_keys.dart';
import '../../../data/providers/local_db/storage_service.dart';
import '../../../data/providers/network_db/api_endpoint.dart';
import '../../../data/providers/network_db/api_provider.dart';

class AuthRepository {
  final StorageService _storageService = Get.find<StorageService>();
  final ApiProvider _apiService = Get.find<ApiProvider>();

  Future<UserModel> login(Map<String, dynamic> data) async {
    final response = await _apiService.post(ApiEndpoints.login, body: data);

    if (response.success && response.data != null) {
      final UserModel user = UserModel.fromJson(response.data);
      await _storageService.write<Map<String, dynamic>>(StorageKeys.currentUser, user.toJson());

      // TOKEN
      await setToken(response.data!['accessToken'], response.data!['refreshToken']);

      return user;
    }

    HLoggerHelper.error("Login failed: ${response.message ?? 'Unknown error'}");
    throw Exception(response.message ?? 'Login failed');
  }

  Future<ResponseModel<bool>> logout() async {
    await _storageService.clear();
    HLoggerHelper.info("User logged out successfully.");
    return ResponseModel.success(true, 'Logout successful');
  }

  UserModel? getCurrentUser() {
    final value = _storageService.read<Map<String, dynamic>>(StorageKeys.currentUser);
    UserModel? user = value != null ? UserModel.fromJson(value) : null;
    HLoggerHelper.debug("Retrieved current user: ${user?.toJson()}");
    return user;
  }

  String? getAccessToken() {
    final token = _storageService.read<String>(StorageKeys.accessToken);
    HLoggerHelper.debug("Retrieved user token: $token");
    return token;
  }

  String? getRefreshToken() {
    final token = _storageService.read<String>(StorageKeys.refreshToken);
    HLoggerHelper.debug("Retrieved user token: $token");
    return token;
  }

  Future<void> setToken(String accessToken, String refreshToken) async {
    await _storageService.write<String>(StorageKeys.accessToken, accessToken);
    await _storageService.write<String>(StorageKeys.refreshToken, refreshToken);
    _apiService.setToken(accessToken);
    HLoggerHelper.debug("Retrieved user token: $accessToken");
  }

  void updateHeader() {
    final String? token = getAccessToken();
    if (token != null) {
      _apiService.setToken(token);
      HLoggerHelper.debug("Updated API header with token: $token");
    } else {
      HLoggerHelper.info("No token found to update API header.");
    }
  }
}
