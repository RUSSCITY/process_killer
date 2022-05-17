import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'process_killer_method_channel.dart';

abstract class ProcessKillerPlatform extends PlatformInterface {
  /// Constructs a ProcessKillerPlatform.
  ProcessKillerPlatform() : super(token: _token);

  static final Object _token = Object();

  static ProcessKillerPlatform _instance = MethodChannelProcessKiller();

  /// The default instance of [ProcessKillerPlatform] to use.
  ///
  /// Defaults to [MethodChannelProcessKiller].
  static ProcessKillerPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ProcessKillerPlatform] when
  /// they register themselves.
  static set instance(ProcessKillerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> killProcessByName(String processName) {
    throw UnimplementedError('killProcessByName() has not been implemented.');
  }

  Future<bool?> killMyselfProcess() {
    throw UnimplementedError('killMyselfProcess() has not been implemented.');
  }
}
