import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'playx_home_launcher_platform_interface.dart';


/// An implementation of [PlayxHomeLauncherPlatform] that uses method channels.
class MethodChannelPlayxHomeLauncher extends PlayxHomeLauncherPlatform {

  static const _methodChannelName ='io.sourcya.playx.home.launcher.method.channel';

  static const _getDefaultLauncherPackageNameMethod = 'getDefaultLauncherPackageName';
  static const _checkIfLauncherIsDefaultMethod = 'checkIfLauncherIsDefault';
  static const _checkIfAppIsLauncherMethod = 'checkIfAppIsLauncher';
  static const _showLauncherSelectionDialogMethod = 'showLauncherSelectionDialog';
  static const _openLauncherSettingsMethod = 'openLauncherSettings';


  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(_methodChannelName);


  @override
  Future<String?> getDefaultLauncherPackageName() {
    return methodChannel.invokeMethod<String>(_getDefaultLauncherPackageNameMethod);
  }

  @override
  Future<bool> checkIfLauncherIsDefault({String? packageName}) async {
    final result =await  methodChannel.invokeMethod<bool>(_checkIfLauncherIsDefaultMethod,packageName);
    return result ?? false;
  }


  @override
  Future<bool> checkIfAppIsLauncher({String? packageName})async {
    final result =await methodChannel.invokeMethod<bool>(_checkIfAppIsLauncherMethod,packageName);
    return result ?? false;
  }

  @override
  Future<void> showLauncherSelectionDialog({String? packageName}) {
    return methodChannel.invokeMethod<void>(_showLauncherSelectionDialogMethod,packageName);
  }

  @override
  Future<void> openLauncherSettings() {
    return methodChannel.invokeMethod<void>(_openLauncherSettingsMethod);
  }
}
