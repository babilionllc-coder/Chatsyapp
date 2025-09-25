import UIKit
import Flutter
import FirebaseCore
//import FBAudienceNetwork

@main
@objc class AppDelegate: FlutterAppDelegate {

  override func applicationDidEnterBackground(_ application: UIApplication){
       application.applicationIconBadgeNumber = 0

    }

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Initialize ImageGalleryHandler
    _ = ImageGalleryHandler.shared
    
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

}
