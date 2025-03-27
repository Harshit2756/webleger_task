import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../core/routes/routes_name.dart';
import '../../../../core/widgets/snackbar/snackbars.dart';
import '../../../modules/auth/repositories/auth_repository.dart';
import '../../models/network/user_model.dart';
import '../base_service.dart';

class AuthService extends BaseService {
  static AuthService get to => Get.find();

  final AuthRepository _repository = Get.find<AuthRepository>();

  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);
  UserModel? get currentUser => _currentUser.value;
  final Rx<String?> _token = Rx<String?>(null);
  bool get isTokenExpired => _token.value != null ? JwtDecoder.isExpired(_token.value!) : false;

  bool get isLoggedIn => _currentUser.value != null;

  /// Method to handle route redirection
  String handleRouteRedirection() {
    if (isLoggedIn && !isTokenExpired) {
      return HRoutesName.home;
    } else {
      if (isTokenExpired) {
        HSnackbars.showSnackbar(type: SnackbarType.warning, message: "The Session Was Expired, login again");
      }
      return HRoutesName.login;
    }
  }

  Future<bool> login(Map<String, dynamic> data) async {
    final user = await _repository.login(data);
    _currentUser.value = user;
    _token.value = _repository.getAccessToken();
    return true;
  }

  Future<void> logout() async {
    await _repository.logout();
    _currentUser.value = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.offAllNamed(HRoutesName.login);
    });
  }

  //
  @override
  void onInit() {
    super.onInit();
    _loadAuthData();
  }

  Future<void> _loadAuthData() async {
    _currentUser.value = _repository.getCurrentUser();
    _token.value = _repository.getAccessToken();
    _repository.updateHeader();
  }
}
