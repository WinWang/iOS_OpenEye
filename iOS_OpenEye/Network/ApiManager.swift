//
//  ApiManager.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/3.
//

class ApiManager {
    // 私有化构造
    private init() {}
    // 实例
    static let shared = ApiManager()
    // 初始化请求service
    lazy var openEyeService: OpenEyeApiService = .init()
}
