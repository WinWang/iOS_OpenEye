//
//  ApiError.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/3.
//

import Alamofire
import Foundation
import Moya

// API错误类型
enum APIError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case serverError(statusCode: Int, message: String?)
    case decodingError(Error)
    case emptyResponse

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "无效的URL"
        case .networkError(let error): return "网络错误: \(error.localizedDescription)"
        case .serverError(let code, let message): return "服务器错误(\(code)): \(message ?? "未知错误")"
        case .decodingError(let error): return "数据解析错误: \(error.localizedDescription)"
        case .emptyResponse: return "响应数据为空"
        }
    }
}
