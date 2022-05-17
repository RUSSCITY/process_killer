import 'process_killer_platform_interface.dart';

class ProcessKiller {
  Future<String?> getPlatformVersion() {
    return ProcessKillerPlatform.instance.getPlatformVersion();
  }

  Future<bool?> killProcessByName(String processName) {
    return ProcessKillerPlatform.instance.killProcessByName(processName);
  }

  Future<bool?> killMyselfProcess() {
    return ProcessKillerPlatform.instance.killMyselfProcess();
  }
}
