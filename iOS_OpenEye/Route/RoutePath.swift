//
//  RoutePath.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/26.
//
enum RoutePath {
    // 详情页面
    private static let detailPath = "openEye://detail/"
    //测试页面-功能入口
    private static let testPath = "openEye://test"
    //collectionView
    private static let collectionViewPath = "openEye://collectionview"
    //刷新页面
    private static let refreshPath = "openEye://refresh"
    
    //路由枚举定义
    case detail(id: String)
    
    case test
    
    case collectionView
    
    case refresh
    
    
    //path获取定义
    
    var path: String {
        switch self {
        case .detail(let id):
            return Self.detailPath + id
        case .test:
            return Self.testPath
        case .collectionView:
            return Self.collectionViewPath
        case .refresh:
            return Self.refreshPath
        }
    }
    
    
    /*****************************************路由注册模板定义**************************************/
    // 详情页路由
    static var detailPattern: String {
        return detailPath + "<id>"
    }
    
    //测试页面-入口
    static var testPattern:String{
        return testPath
    }
    
    //collectionView
    static var collectionViewPattern:String{
        return collectionViewPath
    }
    
    //下拉刷新页面
    static var refreshPattern:String{
        return refreshPath
    }
}
