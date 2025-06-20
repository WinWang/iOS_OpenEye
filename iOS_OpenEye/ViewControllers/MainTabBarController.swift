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
        homeVC.tabBarItem = createItemTabbar(title: "首页", imageName: "home_nor", selectedImageName: "home_sel")
        discoverVC.tabBarItem = createItemTabbar(title: "发现", imageName: "find_nor", selectedImageName: "find_sel")
        hotVC.tabBarItem = createItemTabbar(title: "项目", imageName: "hot_nor", selectedImageName: "hot_sel")
        mintVC.tabBarItem = createItemTabbar(title: "我的", imageName: "mine_nor", selectedImageName: "mine_sel")
        viewControllers = [homeVC, discoverVC, hotVC, mintVC]
        selectedIndex = 0
    }

    /// 创建ItemTabBar
    private func createItemTabbar(title: String, imageName: String, selectedImageName: String) -> UITabBarItem {
        let item = UITabBarItem(
            title: title, image: UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        )
        
        // 未选中状态
        item.setTitleTextAttributes([
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 12)
        ], for: .normal)

        // 选中状态
        item.setTitleTextAttributes([
            .foregroundColor: UIColor.appPrimary,
            .font: UIFont.systemFont(ofSize: 12, weight: .bold)
        ], for: .selected)
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
