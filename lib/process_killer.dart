
import 'process_killer_platform_interface.dart';

class ProcessKiller {
  Future<String?> getPlatformVersion() {
    return ProcessKillerPlatform.instance.getPlatformVersion();
  }
}
