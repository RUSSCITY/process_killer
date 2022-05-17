import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'process_killer_platform_interface.dart';

/// An implementation of [ProcessKillerPlatform] that uses method channels.
class MethodChannelProcessKiller extends ProcessKillerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('process_killer');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> killProcessByName(String processName) async {
    final executed = await methodChannel
        .invokeMethod<bool>('killProcessByName', {"processName": processName});
    return executed;
  }

  @override
  Future<bool?> killMyselfProcess() async {
    final executed = await methodChannel.invokeMethod<bool>(
      'killMyselfProcess',
    );
    return executed;
  }
}
