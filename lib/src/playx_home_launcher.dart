import 'package:playx_home_launcher/src/playx_home_launcher_platform_interface.dart';

/// A utility class to interact with Android launcher-related functionality.
/// Provides utilities to check launcher status, get launcher info,
/// and open launcher settings or prompt selection.
abstract class PlayxHomeLauncher {
  static PlayxHomeLauncherPlatform get _platform => PlayxHomeLauncherPlatform.instance;

  /// Returns the default launcher package name.
  ///
  /// 📌 **Note for Android 11+**:
  /// You must add the following to your `AndroidManifest.xml` for this to work properly:
  /// ```xml
  /// <queries>
  ///   <intent>
  ///     <action android:name="android.intent.action.MAIN" />
  ///     <category android:name="android.intent.category.HOME" />
  ///   </intent>
  /// </queries>
  /// ```
  ///
  /// Otherwise, Android will report `com.android.settings.FallbackHome` as the only home activity.
  static Future<String?> getDefaultLauncherPackageName() {
    return _platform.getDefaultLauncherPackageName();
  }

  /// Returns `true` if the specified app is a launcher app.
  static Future<bool> isLauncherApp({required String packageName}) {
    return _platform.checkIfAppIsLauncher(packageName: packageName);
  }

  /// Returns `true` if the specified app is the default launcher.
  static Future<bool> isDefaultLauncher({required String packageName}) {
    return _platform.checkIfLauncherIsDefault(packageName: packageName);
  }

  /// Returns `true` if the current app is the default launcher.
  static Future<bool> isThisAppTheDefaultLauncher() async {
    return _platform.checkIfLauncherIsDefault(packageName: null);
  }

  /// Returns `true` if the current app is a launcher.
  static Future<bool> isThisAppALauncher() async {
    return _platform.checkIfAppIsLauncher(packageName: null);
  }

  /// Attempts to show the launcher selection dialog so the user can choose their default launcher.
  ///
  /// If the dialog cannot be shown (e.g., the app is not recognized as a launcher or system restrictions apply),
  /// and [openSettingsOnError] is set to `true`, it will automatically redirect the user to the system launcher settings screen.
  ///
  /// - [openSettingsOnError] (optional): If `true` (default), will fallback to opening launcher settings on failure.
  ///
  /// Example:
  /// ```dart
  /// await PlayxHomeLauncher.showLauncherSelectionDialog();
  /// ```
  static Future<bool> showLauncherSelectionDialog({
    bool openSettingsOnError = true,
  }) {
    return _platform.showLauncherSelectionDialog(
      openSettingsOnError: openSettingsOnError,
    );
  }

  /// Opens the system launcher settings page.
  static Future<void> openLauncherSettings() {
    return _platform.openLauncherSettings();
  }

  /// Returns the current app's package name.
  static Future<String> getCurrentPackageName() {
    return _platform.getCurrentPackageName();
  }


}

