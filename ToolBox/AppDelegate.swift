//
//  AppDelegate.swift
//  ToolBox
//
//  Created by Murph on 2022/7/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        HUDManager.setup()
        return true
    }
}

//extension UIApplication {
//    var window: UIWindow? {
//        return UIApplication.shared.connectedScenes
//            .filter { $0.activationState == .foregroundActive }
//            .first(where: { $0 is UIWindowScene })
//            .flatMap({$0 as? UIWindowScene})?
//            .windows.first(where: \.isKeyWindow)
//    }
//}
