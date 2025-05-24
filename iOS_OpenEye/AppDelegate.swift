import UIKit

//
//  AppDelegate.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/22.
//

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // 启动回调
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
        // 全局配置
        configureAppearance()
        print("didFinishLaunchingWithOptions>>>>>>>>>>")
        return true
    }

    private func configureAppearance() {
        // 配置全局UI样式
        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().unselectedItemTintColor = .gray
        UITabBar.appearance().backgroundColor = .systemBackground

        UINavigationBar.appearance().tintColor = .systemBlue
        UINavigationBar.appearance().prefersLargeTitles = true
    }

    // MARK: UISceneSession Lifecycle
}
