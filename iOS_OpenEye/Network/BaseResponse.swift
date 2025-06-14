//
//  BaseResponse.swift
//  iOS_OpenEye
//  定义响应结构基础类
//  Created by WinWang on 2025/6/3.
//
// 基础响应模型
struct BaseResponse<T: Codable>: Codable {
    let code: Int
    let message: String
    let data: T?

    // 自定义解码逻辑（如果需要）--类似Gson @SerializeName
    enum CodingKeys: String, CodingKey {
        case code = "status" // 根据实际API调整
        case message
        case data
    }
}
