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

  runApp(const App());
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
