package io.sourcya.playx.home.launcher.playx_home_launcher.channel_handler

import android.app.Activity
import android.content.Intent
import android.provider.Settings
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.sourcya.playx.home.launcher.playx_home_launcher.manager.LauncherManger

class HomeLauncherMethodHandler : MethodChannel.MethodCallHandler {
    private var channel: MethodChannel? = null
    private var binding: FlutterPlugin.FlutterPluginBinding? = null;
    private var launcherManger: LauncherManger? = null;
    private var activity: Activity? = null

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            GET_DEFAULT_LAUNCHER_PACKAGE_NAME_METHOD -> getDefaultLauncherPackageName(call, result)
            CHECK_IF_LAUNCHER_IS_DEFAULT_METHOD -> checkIfLauncherIsDefault(call, result)
            CHECK_IF_APP_IS_LAUNCHER_METHOD -> checkIfAppIsLauncher(call, result)
            SHOW_LAUNCHER_SELECTION_DIALOG_METHOD -> showLauncherSelectionDialog(call, result)
            OPEN_LAUNCHER_SETTINGS_METHOD -> openLauncherSettings(result)
            GET_CURRENT_PACKAGE_NAME_METHOD -> getCurrentPackageName(call, result)
            else -> result.notImplemented()
        }
    }


    // Get current default launcher package name
    // Note starting from Android 11.
    // With the package visibility changes introduced in Android 11,
    // it is now necessary to add a queries element in your application's manifest file as below before you can query one of the PackageManager.resolveActivity(intent:flags:),
    // PackageManager.queryIntentActivities(intent:flags:) etc methods for the home (a.k.a. launcher) activities that are installed on the device:
    //
    //<queries>
    //    <intent>
    //        <action android:name="android.intent.action.MAIN" />
    //        <category android:name="android.intent.category.HOME" />
    //    </intent>
    //</queries>
    // If this queries element is omitted from your application's manifest, then the device will report the com.android.settings.FallbackHome
    // activity as the one and only home activity installed on the device.
    private fun getDefaultLauncherPackageName(call: MethodCall, result: MethodChannel.Result) {
        if (launcherManger == null) {
            result.error("launcher_not_initialized", "Launcher manger is Not initialized", null)
            return;
        }

        val packageName = launcherManger!!.getCurrentDefaultLauncherPackageName()
        result.success(packageName)
    }


    // Check if an app is the default launcher.
    // Can take packageName as parameter to check with it if not it will use the app package name.
    private fun checkIfLauncherIsDefault(call: MethodCall, result: MethodChannel.Result) {
        if (launcherManger == null) {
            result.error("launcher_not_initialized", "Launcher manger is Not initialized", null)
            return;
        }
        val packageName: String? = call.arguments as String?

        val isDefault = launcherManger!!.isMyLauncherDefault(packageName)
        result.success(isDefault)
    }

    // Check if an app is a launcher app or not.
    // Can take packageName as parameter to check with it if not it will use the app package name.
    private fun checkIfAppIsLauncher(call: MethodCall, result: MethodChannel.Result) {
        if (launcherManger == null) {
            result.error("launcher_not_initialized", "Launcher manger is Not initialized", null)
            return;
        }
        val packageName: String? = call.arguments as String?

        val isLauncher = launcherManger!!.isLauncherApp(packageName)
        result.success(isLauncher)
    }

    // Show Launcher selection dialog to select the default launcher.
    // If The app can't show the dialog, It will open the launcher settings.
    private fun showLauncherSelectionDialog(call: MethodCall, result: MethodChannel.Result) {
        if (launcherManger == null) {
            result.error("launcher_not_initialized", "Launcher manger is Not initialized", null)
            return;
        }
        val args = call.arguments as Map<*, *>
        val packageName: String? = args["packageName"] as String?
        val openSettingsOnError: Boolean = args["openSettingsOnError"] as Boolean


        val intent = launcherManger!!.getLauncherSelectionIntent(packageName, openSettingsOnError);
        if (intent == null) {
            result.success(false);
            return;
        }
        Log.d("TAG", "showLauncherSelectionDialog: $intent")
        if (activity == null) {
            result.error("activity_not_initialized", "Activity is Not initialized", null)
            return;
        }

        activity!!.startActivityForResult(intent, 0)
        result.success(true)
    }


    // Open launcher settings.
    private fun openLauncherSettings(result: MethodChannel.Result) {
        val intent = Intent(Settings.ACTION_HOME_SETTINGS);
        if (activity == null) {
            result.error("activity_not_initialized", "Activity is Not initialized", null)
            return;
        }

        activity!!.startActivityForResult(intent, 1)
        result.success(true)
    }

    // Get current package name.
    private fun getCurrentPackageName(call: MethodCall, result: MethodChannel.Result) {
        if (launcherManger == null) {
            result.error("launcher_not_initialized", "Launcher manger is Not initialized", null)
            return;
        }
        val packageName = launcherManger!!.getCurrentPackageName()
        result.success(packageName)
    }


    /**
     * Registers this instance as a method call handler on the given `messenger`.
     * Stops any previously started and unstopped calls.
     * This should be cleaned with [.stopListening] once the messenger is disposed of.
     */
    fun startListening(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        if (channel != null) stopListening()
        launcherManger = LauncherManger(flutterPluginBinding.applicationContext)

        binding = flutterPluginBinding
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, PLAYX_METHOD_CHANNEL_NAME)
        channel?.setMethodCallHandler(this)

    }


    /**
     * Clears this instance from listening to method calls.
     * Does nothing if [.startListening] hasn't been called, or if we're already stopped.
     */
    fun stopListening() {
        channel?.setMethodCallHandler(null)
        launcherManger = null;
        channel = null
        binding = null

    }

    fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activity = binding.activity

    }

    fun onDetachedFromActivity() {
        activity = null
    }


    companion object {

        const val PLAYX_METHOD_CHANNEL_NAME = "io.sourcya.playx.home.launcher.method.channel"

        const val GET_DEFAULT_LAUNCHER_PACKAGE_NAME_METHOD = "getDefaultLauncherPackageName"
        const val CHECK_IF_LAUNCHER_IS_DEFAULT_METHOD = "checkIfLauncherIsDefault"
        const val CHECK_IF_APP_IS_LAUNCHER_METHOD = "checkIfAppIsLauncher"
        const val SHOW_LAUNCHER_SELECTION_DIALOG_METHOD = "showLauncherSelectionDialog"
        const val OPEN_LAUNCHER_SETTINGS_METHOD = "openLauncherSettings"
        const val GET_CURRENT_PACKAGE_NAME_METHOD = "getCurrentPackageName"

    }


}