//
//  RoutePath.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/26.
//
enum RoutePath {
    // 首页主页
    private static let mainPath = "openEye://main/"
    // 详情页面
    private static let detailPath = "openEye://detail/"
    // 测试页面-功能入口
    private static let testPath = "openEye://test"
    // collectionView
    private static let collectionViewPath = "openEye://collectionview"
    // 刷新页面
    private static let refreshPath = "openEye://refresh"
    // 页面状态页面
    private static let stateLayoutPath = "openEye://stateLayout"
    
    // 路由枚举定义
    case main
    
    // 详情页面
    case detail(id: String)
    
    // 测试页面
    case test
    
    // 测试Collectionview页面
    case collectionView
    
    // 刷新页面
    case refresh
    
    // 页面状态页面
    case statePage
    
    // path获取定义
    
    var path: String {
        switch self {
        case .main:
            return Self.mainPath
        case .detail(let id):
            return Self.detailPath + id
        case .test:
            return Self.testPath
        case .collectionView:
            return Self.collectionViewPath
        case .refresh:
            return Self.refreshPath
        case .statePage:
            return Self.stateLayoutPath
        }
    }
    
    /*****************************************路由注册模板定义**************************************/
    // 首页主页
    static var mainPattern: String {
        return mainPath
    }
    
    // 详情页路由
    static var detailPattern: String {
        return detailPath + "<id>"
    }
    
    // 测试页面-入口
    static var testPattern: String {
        return testPath
    }
    
    // collectionView
    static var collectionViewPattern: String {
        return collectionViewPath
    }
    
    // 下拉刷新页面
    static var refreshPattern: String {
        return refreshPath
    }
    
    // 页面状态测试
    static var stateLayoutPattern: String {
        return stateLayoutPath
    }
}
