package software.ragimov.process_killer

import android.app.ActivityManager
import android.content.Context
import android.os.Process
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ProcessKillerPlugin */
class ProcessKillerPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "process_killer")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "killProcessByName") {
            val processName = call.argument<String>("processName")
            Log.d("ProcessKillerPlugin", "Try to kill this process: $processName")
            val a: ActivityManager =
                context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
            for (service in a.getRunningServices(99999999)) {
                Log.d(
                    "ProcessKillerPlugin",
                    "running service: ${service.process} ${service.pid}-pid"
                )
                if (service.process == processName) {
                    Log.d(
                        "ProcessKillerPlugin",
                        "Will kill found process"
                    )
                    Process.killProcess(service.pid)
                }
            }
            result.success(true)
        } else if (call.method == "killMyselfProcess") {
            Log.d("ProcessKillerPlugin", "Killing my pid: " + Process.myPid())
            Process.killProcess(Process.myPid())
            result.success(true)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
