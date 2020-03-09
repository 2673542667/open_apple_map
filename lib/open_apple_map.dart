import 'dart:async';

import 'package:flutter/services.dart';

class OpenAppleMap {
  static const MethodChannel _channel =
      const MethodChannel('open_apple_map');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> openMap(log, lat) async {
    final Map res = await _channel.invokeMethod('openMap', <String, dynamic>{'lat': lat, 'log': log});
    bool isOpen = res['isOpen'];
    return isOpen;
  }
}
