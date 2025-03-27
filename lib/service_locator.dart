import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import 'app/data/providers/local_db/storage_service.dart';
import 'app/data/providers/network_db/api_provider.dart';
import 'app/data/services/auth/auth_service.dart';
import 'app/data/services/internet/internet_service.dart';
import 'app/modules/auth/repositories/auth_repository.dart';

Future<void> initServices() async {
  Get.put(CheckInternetService(), permanent: true);
  await Get.putAsync<StorageService>(() async => StorageService().init(), permanent: true);
  Get.put(ApiProvider(), permanent: true);
  Get.put(AuthRepository(), permanent: true);
  Get.put(AuthService(), permanent: true);
}
