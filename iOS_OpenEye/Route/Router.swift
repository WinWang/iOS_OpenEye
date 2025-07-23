import UIKit
import URLNavigator

//
//  Router.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/26.
//
final class Router {
    private var window: UIWindow?
    static let shared = Router()
    private let navigator = Navigator()

    private init() {
        registerRoutes()
    }

    private func registerRoutes() {
        // 首页主页
        navigator.register(RoutePath.mainPattern) { _, _, _ in
            MainTabBarController()
        }
        // 详情页
        navigator.register(RoutePath.detailPattern) { _, values, context in
            let param = context as? [String: String]
            let playUrl = param?["playUrl"]
            // 如果Int类型转换失败，尝试从String转换
            if let id = values["id"] as? Int {
                return VideoDetailViewController(id: id, playUrl: playUrl ?? AppConstant.EMPTY)
            }
            return nil
        }
        // 注册分类详情页面
        navigator.register(RoutePath.categoryDetailPattern) { _, _, context in
            let param = context as? [String: Any]
            let backUrl = (param?["backUrl"] as? String ?? AppConstant.EMPTY)
            let id = (param?["id"] as? Int ?? 0)
            let titleString = (param?["title"] as? String ?? AppConstant.EMPTY)
            return CategoryDetailViewController(id: id, titleString: titleString, headerImg: backUrl)
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
        // 页面状态页面
        navigator.register(RoutePath.stateLayoutPattern) { _, _, _ in
            TestStateViewController()
        }
        //专栏详情页面
        navigator.register(RoutePath.topicDetailPattern) { _, values, _ in
            if let id = values["id"] as? Int {
                return TopicDetailViewController(id: id)
            }
            return nil
        }
    }

    func setUIWindow(uiWindow: UIWindow?) {
        window = uiWindow
    }

    /// 切换主控制器
    func replaceMainController() {
        window?.rootViewController = MainTabBarController()
    }

    /// 路由push方法
    func push(_ route: RoutePath, context: [AnyHashable: Any]? = nil, from: UIViewController? = nil, animated: Bool = true, hidesTabBar: Bool = true) {
        if let viewController = navigator.viewController(for: route.path, context: context) {
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
