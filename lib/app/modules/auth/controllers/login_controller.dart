import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/helpers/logger.dart';
import '../../../../core/widgets/snackbar/snackbars.dart';
import '../../../data/services/auth/auth_service.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final isLoading = false.obs;
  final usernameController = TextEditingController(text: 'michaelw');
  final passwordController = TextEditingController(text: 'michaelwpass');
  final AuthService _authService = Get.find<AuthService>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  /// Focus Nodes
  late final usernameFocusNode = FocusNode();
  late final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!_validateInputs()) return;

    try {
      isLoading.value = true;
      final success = await _authService.login(
        {
          'username': usernameController.text.trim(),
          'password': passwordController.text.trim(),
        },
      );

      if (success) {
        Get.offAllNamed(_authService.handleRouteRedirection());
        HSnackbars.showSnackbar(type: SnackbarType.success, message: 'Login successful');
      }
    } catch (e) {
      HLoggerHelper.error("Login failed: $e");
      HSnackbars.showSnackbar(type: SnackbarType.error, message: e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  void togglePasswordVisibility() => hidePassword.toggle();

  bool _validateInputs() {
    if (!loginFormKey.currentState!.validate()) {
      return false;
    }
    return true;
  }
}
