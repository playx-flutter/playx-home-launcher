package io.sourcya.playx.home.launcher.playx_home_launcher.manager

import android.app.role.RoleManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import androidx.annotation.RequiresApi


class LauncherManger constructor(
    private val context: Context
) {


    private val roleManager: RoleManager? by lazy {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            context.getSystemService(Context.ROLE_SERVICE) as RoleManager
        } else {
            null
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
    fun getCurrentDefaultLauncherPackageName(): String? {
        val intent = Intent(Intent.ACTION_MAIN)
        intent.addCategory(Intent.CATEGORY_HOME)

        val resolveInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)
            context.packageManager.resolveActivity(
                intent, PackageManager.ResolveInfoFlags.of(
                    PackageManager.MATCH_DEFAULT_ONLY.toLong()
                )
            )
        else
            context.packageManager.resolveActivity(intent, PackageManager.MATCH_DEFAULT_ONLY)
        return resolveInfo?.activityInfo?.packageName;

    }

    // Check if an app is a launcher app or not.
    fun isLauncherApp(packageName: String?): Boolean {
        val myPackageName = packageName ?: context.packageName
        val pm = context.packageManager

        val intent = Intent(Intent.ACTION_MAIN)
        intent.addCategory(Intent.CATEGORY_HOME)

        val resolveInfoList = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)
            pm.queryIntentActivities(
                intent,
                PackageManager.ResolveInfoFlags.of(PackageManager.MATCH_ALL.toLong())
            )
        else
            pm.queryIntentActivities(intent, PackageManager.MATCH_ALL)

        for (resolveInfo in resolveInfoList) {
            if (resolveInfo.activityInfo.packageName == myPackageName) {
                return true
            }
        }
        return false
    }


    // Check if your app is the default launcher.
    fun isMyLauncherDefault(packageName: String?): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q && isRoleAvailable()) {
            roleManager!!.isRoleHeld(RoleManager.ROLE_HOME)
        } else {
            val currentDefaultPackage = getCurrentDefaultLauncherPackageName();
            return currentDefaultPackage == (packageName ?: context.packageName);
        }
    }


    // Get the intent to launch the launcher selection screen.
    fun getLauncherSelectionIntent(packageName: String?, openSettingsOnError: Boolean): Intent? {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q && isRoleAvailable()
        ) {
            return roleManager!!.createRequestRoleIntent(RoleManager.ROLE_HOME)
        }
        if (openSettingsOnError) {
            val settingsIntent = Intent(Settings.ACTION_HOME_SETTINGS)
            return settingsIntent

        }
        return null;

    }


    @RequiresApi(Build.VERSION_CODES.Q)
    fun isRoleAvailable(): Boolean {
        return if (roleManager != null) {
            roleManager!!.isRoleAvailable(RoleManager.ROLE_HOME)
        } else {
            false
        }
    }

    fun getCurrentPackageName(): String {
        return context.packageName
    }


}