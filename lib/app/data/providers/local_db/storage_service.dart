import 'package:get_storage/get_storage.dart';

import '../../../../core/utils/helpers/logger.dart';
import '../../services/base_service.dart';

class StorageService extends BaseService {
  late final GetStorage _box;

  Future<void> clear() async {
    try {
      await _box.erase();
      HLoggerHelper.info('Storage cleared successfully');
    } catch (e) {
      HLoggerHelper.error('Error clearing storage: $e');
    }
  }

  Future<StorageService> init() async {
    try {
      await GetStorage.init();
      _box = GetStorage();
      HLoggerHelper.info('Storage service initialized successfully');
      return this;
    } catch (e) {
      HLoggerHelper.error('Error initializing storage: $e');
      rethrow;
    }
  }

  T? read<T>(String key) {
    try {
      final value = _box.read<T>(key);
      HLoggerHelper.debug('Successfully read value of type <${value.runtimeType}>: $value from key: $key');
      return value;
    } catch (e, stackTrace) {
      HLoggerHelper.error('Error reading type <$T> from storage at $key, Error: $e \n StackTrace: $stackTrace');
      return null;
    }
  }

  Future<void> remove(String key) async {
    try {
      await _box.remove(key);
      HLoggerHelper.info('Successfully removed value at key: $key');
    } catch (e) {
      HLoggerHelper.error('Error removing from storage at $key , Error: $e');
    }
  }

  Future<void> write<T>(String key, T value) async {
    try {
      await _box.write(key, value);
      HLoggerHelper.info('Successfully wrote value of type <${value.runtimeType}> : $value at key: $key');
    } catch (e) {
      HLoggerHelper.error('Error writing type <${value.runtimeType}> to storage at $key : $value , Error: $e');
    }
  }
}
