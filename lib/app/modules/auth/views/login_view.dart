import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webleger_task/core/utils/extension/validator.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/constants/text_strings.dart';
import '../../../../core/widgets/appbar/custom_appbar.dart';
import '../../../../core/widgets/buttons/custom_button.dart';
import '../../../../core/widgets/inputs/text_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      appBar: CustomAppBar.withText(
        title: HTexts.signIn,
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(HSizes.md16),
            child: Column(
              children: [
                const SizedBox(height: HSizes.spaceBtwSections32),
                // Logo with circular background
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: HColors.primary,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: FlutterLogo(
                      size: 80,
                      style: FlutterLogoStyle.stacked,
                      textColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: HSizes.spaceBtwSections32),
                // Card containing text fields and buttons
                Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(horizontal: HSizes.md16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(HSizes.cardRadiusLg16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 3,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(HSizes.md16),
                    child: Form(
                      key: controller.loginFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            HTexts.welcomeBack,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: HSizes.sm8),
                          Text(
                            HTexts.pleaseSignInToYourAccount,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(height: HSizes.spaceBtwSections32),
                          CustomTextField(
                            type: TextFieldType.username,
                            focusNode: controller.usernameFocusNode,
                            controller: controller.usernameController,
                            onFieldSubmitted: (value) {
                              controller.usernameFocusNode.unfocus();
                              controller.passwordFocusNode.requestFocus();
                            },
                          ),
                          const SizedBox(height: HSizes.spaceBtwInputFields16),
                          Obx(
                            () => CustomTextField(
                              type: TextFieldType.password,
                              focusNode: controller.passwordFocusNode,
                              controller: controller.passwordController,
                              isPasswordVisible: controller.hidePassword.value,
                              onIconTap: () => controller.togglePasswordVisibility(),
                              validator: (value) => value.validateNotEmpty(HTexts.password),
                            ),
                          ),
                          const SizedBox(height: HSizes.spaceBtwSections32),
                          Obx(
                            () => CustomButton(
                              text: HTexts.signIn,
                              isLoading: controller.isLoading.value,
                              onPressed: controller.login,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(HTexts.dontHaveAnAccount),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
