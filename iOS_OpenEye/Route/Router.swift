import UIKit
import URLNavigator

//
//  Router.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/26.
//
final class Router {
    static let shared = Router()
    private let navigator = Navigator()

    private init() {
        registerRoutes()
    }

    private func registerRoutes() {
        // 详情页
        navigator.register(RoutePath.detailPattern) { _, values, _ in
            guard let id = values["id"] as? String else { return nil }
            return DetailViewController(id: id)
        }
        // 测试页面
        navigator.register(RoutePath.testPattern) { _, _, _ in
            TestViewController()
        }
        // CollectionView测试页面
        navigator.register(RoutePath.collectionViewPattern) { _, _, _ in
            TestCollectionViewController()
        }
        // 刷新页面
        navigator.register(RoutePath.refreshPattern) { _, _, _ in
            TestRefreshViewController()
        }
    }

    /// 路由push方法
    func push(_ route: RoutePath, from: UIViewController? = nil, animated: Bool = true, hidesTabBar: Bool = true) {
        if let viewController = navigator.viewController(for: route.path) {
            viewController.hidesBottomBarWhenPushed = hidesTabBar
            navigator.push(viewController)
        } else {
            print("未匹配到路由")
        }
    }

    /// 路由pop方法
    func pop() {
        UIViewController.topMost?.navigationController?.popViewController(animated: true)
    }
}
