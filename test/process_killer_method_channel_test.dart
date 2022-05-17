import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:process_killer/process_killer_method_channel.dart';

void main() {
  MethodChannelProcessKiller platform = MethodChannelProcessKiller();
  const MethodChannel channel = MethodChannel('process_killer');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
