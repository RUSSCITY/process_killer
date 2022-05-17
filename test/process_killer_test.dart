import 'package:flutter_test/flutter_test.dart';
import 'package:process_killer/process_killer.dart';
import 'package:process_killer/process_killer_platform_interface.dart';
import 'package:process_killer/process_killer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockProcessKillerPlatform 
    with MockPlatformInterfaceMixin
    implements ProcessKillerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ProcessKillerPlatform initialPlatform = ProcessKillerPlatform.instance;

  test('$MethodChannelProcessKiller is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelProcessKiller>());
  });

  test('getPlatformVersion', () async {
    ProcessKiller processKillerPlugin = ProcessKiller();
    MockProcessKillerPlatform fakePlatform = MockProcessKillerPlatform();
    ProcessKillerPlatform.instance = fakePlatform;
  
    expect(await processKillerPlugin.getPlatformVersion(), '42');
  });
}
