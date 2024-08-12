import UIKit
import Flutter
import cupertino_http

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let config:CUPCronetConfig = CUPCronetConfig()
    config.interceptHostWhiteList = ["googleapis.com"]
    config.httpCacheMode = .disabled
    CUPCronet.start(config: config)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
