//
//  OpenEyeApiService.swift
//  iOS_OpenEye
//  接口服务
//  Created by WinWang on 2025/6/3.
//

import Moya
import Combine

class OpenEyeApiService: APIServiceType {
    typealias Target = OpenEyeApi
    
    // 创建带有日志插件的接口请求Provider
    let provider = MoyaProvider<OpenEyeApi>(plugins: moyaPlugins)
    
    func getHomeList(data: String)->AnyPublisher<HomeModel,APIError> {
        return requestPublisher(.home(data: data))
    }
}
