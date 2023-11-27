//
//  AppDelegate.swift
//  indonesia-keyboard
//
//  Created by Kurniadi on 25/11/23.
//

import UIKit
import Firebase

class TempStorage {
    var uuid = ""
    var age = 0
    var sex = 0
    var fluently = 0
    var qwertyTracked = ""
    var proposedTracked = ""
    var colemakTracked = ""
    
    static let shared = TempStorage()
    
    func getDictionary() -> [String: Any] {
        return [
            "qwertyTracked": qwertyTracked,
            "proposedTracked": proposedTracked,
            "colemakTracked": colemakTracked,
            "age": age,
            "sex": sex,
            "fluently": fluently
        ]
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
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

