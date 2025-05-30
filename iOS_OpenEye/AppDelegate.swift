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
        initApp()
        return true
    }

    // App 启动初始化回调
    private func initApp() {
        // 全局配置
        configureAppearance()
        // 初始化日志
        initLogger()
    }

    private func configureAppearance() {
        // 配置全局UI样式
        UITabBar.appearance().tintColor = .systemRed
        UITabBar.appearance().unselectedItemTintColor = .gray
        UITabBar.appearance().backgroundColor = .systemBackground

        UINavigationBar.appearance().tintColor = .appPrimary
        UINavigationBar.appearance().prefersLargeTitles = true

        // 全局配置返回按钮
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        barButtonItemAppearance.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
        barButtonItemAppearance.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .highlighted)
    }

    // MARK: UISceneSession Lifecycle
}
