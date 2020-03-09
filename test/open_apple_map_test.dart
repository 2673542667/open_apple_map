import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_apple_map/open_apple_map.dart';

void main() {
  const MethodChannel channel = MethodChannel('open_apple_map');

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
    expect(await OpenAppleMap.openMap, '42');
  });
}
