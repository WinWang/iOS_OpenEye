import UIKit

//
//  MainTabBarController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/22.
//

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        initViewControllers()
        setTabBarAppearance()
    }

    /// 初始化所有的控制器
    private func initViewControllers() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let discoverVC = UINavigationController(rootViewController: DiscoverViewController())
        let hotVC = UINavigationController(rootViewController: HotViewController())
        let mintVC = UINavigationController(rootViewController: MineViewController())

        // 配置TabBarItem
        homeVC.tabBarItem = createItemTabbar(title: "首页", imageName: "house", selectedImageName: "house.fill")
        homeVC.tabBarItem = createItemTabbar(title: "发现", imageName: "magnifyingglass", selectedImageName: "magnifyingglass.fill")
        homeVC.tabBarItem = createItemTabbar(title: "项目", imageName: "folder", selectedImageName: "folder.fill")
        homeVC.tabBarItem = createItemTabbar(title: "我的", imageName: "person", selectedImageName: "person.fill")
        viewControllers = [homeVC, discoverVC, hotVC, mintVC]
        selectedIndex = 0
    }

    /// 创建ItemTabBar
    private func createItemTabbar(title: String, imageName: String, selectedImageName: String) -> UITabBarItem {
        let item = UITabBarItem(
            title: title, image: UIImage(systemName: imageName), selectedImage: UIImage(systemName: selectedImageName)
        )
        item.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        return item
    }

    // 自定义TabBar外观
    private func setTabBarAppearance() {
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        tabBar.layer.shadowRadius = 3
    }
}
