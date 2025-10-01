import UIKit

/*
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
*/


// MARK: - App Bootstrap (@main)

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? // used for iOS 12 and below

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // If you target iOS 12 or earlier, uncomment to bootstrap here:
        // let window = UIWindow(frame: UIScreen.main.bounds)
        // self.window = window
        // let app = AppCoordinator(window: window, isAuthenticated: false)
        // app.start()
        // self._appCoordinator = app
        return true
    }

    // Keep a strong ref if you bootstrap from AppDelegate (iOS 12-):
    private var _appCoordinator: AppCoordinator?

    /// _appCoordinator property to keep the coordinator alive. AppCoordinator isn’t retained by the window or the navigation controller (retention is one-way: the coordinator holds the UINavigationController, not the other way around). If we create it as a local in didFinishLaunching and don’t store it, it gets deallocated as soon as that method returns — the navigation closures stop working and nothing will push/present.
}
