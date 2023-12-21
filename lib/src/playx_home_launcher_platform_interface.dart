import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'playx_home_launcher_method_channel.dart';

abstract class PlayxHomeLauncherPlatform extends PlatformInterface {
  /// Constructs a PlayxHomeLauncherPlatform.
  PlayxHomeLauncherPlatform() : super(token: _token);

  static final Object _token = Object();

  static PlayxHomeLauncherPlatform _instance = MethodChannelPlayxHomeLauncher();

  /// The default instance of [PlayxHomeLauncherPlatform] to use.
  ///
  /// Defaults to [MethodChannelPlayxHomeLauncher].
  static PlayxHomeLauncherPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PlayxHomeLauncherPlatform] when
  /// they register themselves.
  static set instance(PlayxHomeLauncherPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getDefaultLauncherPackageName(){
    throw UnimplementedError('getDefaultLauncherPackageName() has not been implemented.');
  }

  Future<bool> checkIfLauncherIsDefault({String? packageName}){
    throw UnimplementedError('checkIfLauncherIsDefault() has not been implemented.');
  }

  Future<bool> checkIfAppIsLauncher({String? packageName}){
    throw UnimplementedError('checkIfAppIsLauncher() has not been implemented.');
  }

  Future<void> showLauncherSelectionDialog({String? packageName}){
    throw UnimplementedError('showLauncherSelectionDialog() has not been implemented.');
  }

  Future<void> openLauncherSettings(){
    throw UnimplementedError('openLauncherSettings() has not been implemented.');
  }

}
