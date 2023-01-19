import UIKit
import Flutter
import workmanager


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*5))
        WorkmanagerPlugin.setPluginRegistrantCallback { registry in
            GeneratedPluginRegistrant.register(with: registry)
        }
        
        WorkmanagerPlugin.registerTask(withIdentifier: "update-widget")
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
