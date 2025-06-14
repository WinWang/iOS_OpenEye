//
//  NetworkLoggerPlugin.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/3.
//

import Foundation
import Moya

/// moya网络请求插件
let moyaPlugins = [NetworkLoggerPlugin()]

/// 网络请求拦截插件
class NetworkLoggerPlugin: PluginType {
    func prepare(_ request: URLRequest, target: any TargetType) -> URLRequest {
        logDebug("==> API Request: \(target.path)")
        logDebug("==> Method: \(target.method.rawValue)")
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            logDebug("==> Body: \(bodyString)")
        }
        return request
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: any TargetType) {
        switch result {
            case .success(let response):
                logDebug("✅ API Response (\(target.path)): \(response.statusCode)", tag: "_test")
                if response.statusCode == 200 {
                    logDebug(response.prettyPrintJSON)
                }

            // 可以选择性打印响应数据（大型响应可能影响性能）
//                if let jsonString = String(data: response.data, encoding: .utf8) {
//                    logDebug("Response==> Data: \(jsonString)")
//                    logJSON(jsonString)
//                    logHttp(jsonString)
//                }
            case .failure(let error):
                logDebug("❌ API Error (\(target.path)): \(error.localizedDescription)")
                if let response = error.response {
                    logError("   Status Code: \(response.statusCode)")
                }
        }
    }
}

/// 对Moya的Response做只读属性的扩展,打印漂亮的json
extension Moya.Response {
    /// json打印
    var prettyPrintJSON: String {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8)
        {
            return jsonString
        }
        return ""
    }

    var any: Any? {
        try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }

    var array: [Any]? {
        any as? [Any]
    }

    var dictionary: [String: Any]? {
        any as? [String: Any]
    }
}
