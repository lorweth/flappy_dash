import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

class SettingsController {
  static final _log = Logger('SettingsController');

  /// Whether or not the debug mode are on.
  ValueNotifier<bool> isDebugMode = ValueNotifier(false);

  SettingsController();

  void toggleDebugMode() {
    isDebugMode.value = !isDebugMode.value;
    _log.info('Debug mode: ${isDebugMode.value}');
  }
}
