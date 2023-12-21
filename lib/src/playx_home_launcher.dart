
import 'package:playx_home_launcher/src/playx_home_launcher_platform_interface.dart';


abstract class PlayxHomeLauncher {

  static PlayxHomeLauncherPlatform get instance => PlayxHomeLauncherPlatform.instance;

  /// Returns the default launcher package name.
  /// Note starting from Android 11.
  /// With the package visibility changes introduced in Android 11,
  /// it is now necessary to add a queries element in your application's manifest file as below before you can query one of the PackageManager.resolveActivity(intent:flags:),
  /// PackageManager.queryIntentActivities(intent:flags:) etc methods for the home (a.k.a. launcher) activities that are installed on the device:
  ///
  ///<queries>
  ///    <intent>
  ///        <action android:name="android.intent.action.MAIN" />
  ///        <category android:name="android.intent.category.HOME" />
  ///    </intent>
  ///</queries>
  /// If this queries element is omitted from your application's manifest, then the device will report the com.android.settings.FallbackHome
  /// activity as the one and only home activity installed on the device.
  static Future<String?> getDefaultLauncherPackageName() => instance.getDefaultLauncherPackageName();

  /// Returns true if the app is a launcher.
  /// Can take packageName as parameter to check with it if not it will use the app package name.
  static Future<bool?> checkIfAppIsLauncher({String? packageName}) => instance.checkIfAppIsLauncher(packageName:packageName);

  /// Returns true if the app is the default launcher.
  // Can take packageName as parameter to check with it if not it will use the app package name.
  static Future<bool?> checkIfLauncherIsDefault({String? packageName}) => instance.checkIfLauncherIsDefault(packageName:packageName);

  /// Shows the launcher selection dialog.
  /// If The app can't show the dialog, It will open the launcher settings.
  /// Can take packageName as parameter to check with it if The app is a launcher app or not.
  static Future<void> showLauncherSelectionDialog({String? packageName}) => instance.showLauncherSelectionDialog(packageName:packageName);

  /// Opens the launcher settings on device.
  static Future<void> openLauncherSettings() => instance.openLauncherSettings();


}
