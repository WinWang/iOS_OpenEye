//
//  RoutePath.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/26.
//
enum RoutePath {
    // 详情页面
    private static let detailPath = "openEye://detail/"
    
    case detail(id: String)
    
    var path: String {
        switch self {
        case .detail(let id):
            return Self.detailPath + id
        }
    }
    
    // 详情页路由
    static var detailPattern: String {
        return detailPath + "<id>"
    }
}
