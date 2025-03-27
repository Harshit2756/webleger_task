import 'package:get/get.dart';

// Routes
import '../../app/modules/auth/views/login_view.dart';
import '../../app/modules/auth/views/splash_view.dart';
import '../../app/modules/home/views/home_view.dart';
import 'routes_name.dart';

class HAppRoutes {
  // This is the initial route of your app
  static const initial = HRoutesName.splash;

  // App pages configuration
  static final routes = [
    // Splash Page
    GetPage(
      name: HRoutesName.splash,
      page: () => const SplashView(),
    ),
    // Auth Pages
    GetPage(
      name: HRoutesName.login,
      page: () => const LoginView(),
    ),
    // Home Pages
    GetPage(
      name: HRoutesName.home,
      page: () => const HomeView(),
    ),
  ];
}
