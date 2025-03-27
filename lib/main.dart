import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:device_preview/device_preview.dart';
import 'device_preview_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/colors.dart';
import 'core/theme/theme.dart';
import 'core/utils/constants/text_strings.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: HColors.primary,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  runApp(
    DevicePreview(
      backgroundColor: Colors.white, 
      tools: const [
        CustomPlugin(
          apkDownloadUrl: "https://github.com/Harshit2756/webleger_task/releases/download/v1.0.2/app-release.apk",
          sourceCodeUrl: "https://github.com/Harshit2756/webleger_task/archive/refs/tags/v1.0.2.zip",
        ),
        DeviceSection(frameVisibility: true, orientation: false, virtualKeyboard: true, model: true),
        SettingsSection(backgroundTheme: false, toolsTheme: true),
        // SystemSection(locale: false, theme: false),
        DevicePreviewScreenshot(),
      ],
      devices: [
        Devices.android.samsungGalaxyA50,
        Devices.android.samsungGalaxyNote20,
        Devices.android.samsungGalaxyS20,
        Devices.android.samsungGalaxyNote20Ultra,
        Devices.android.onePlus8Pro,
        Devices.android.sonyXperia1II,
        Devices.ios.iPhoneSE,
        Devices.ios.iPhone12,
        Devices.ios.iPhone12Mini,
        Devices.ios.iPhone12ProMax,
        Devices.ios.iPhone13,
        Devices.ios.iPhone13ProMax,
        Devices.ios.iPhone13Mini,
        Devices.ios.iPhoneSE,
      ],
      enabled: true,
      builder: (context) => const App(),
    ),
  );
}
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: HTexts.appName,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: HAppTheme.lightTheme,
      initialRoute: HAppRoutes.initial,
      getPages: HAppRoutes.routes,
      defaultTransition: Transition.fadeIn,
    );
  }
}
