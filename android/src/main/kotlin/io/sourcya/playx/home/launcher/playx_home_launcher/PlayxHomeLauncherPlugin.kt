package io.sourcya.playx.home.launcher.playx_home_launcher

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.sourcya.playx.home.launcher.playx_home_launcher.channel_handler.HomeLauncherMethodHandler

/** PlayxHomeLauncherPlugin */
class PlayxHomeLauncherPlugin: FlutterPlugin, ActivityAware {

  private var handler : HomeLauncherMethodHandler?= null;
  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    handler?.stopListening();
    handler = HomeLauncherMethodHandler().apply {
      startListening(flutterPluginBinding)
    }
  }


  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    handler?.stopListening()
    handler = null
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    handler?.onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    handler?.onDetachedFromActivity()
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
  }

  override fun onDetachedFromActivity() {
  }
}
