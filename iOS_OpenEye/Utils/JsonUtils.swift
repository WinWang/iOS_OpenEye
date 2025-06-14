//
//  JsonUtils.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/5.
//

import Foundation

func formatJSON(_ json: Any, prettyPrinted: Bool = true) -> String {
    do {
        let options: JSONSerialization.WritingOptions = prettyPrinted ? [.prettyPrinted] : []
        let data = try JSONSerialization.data(withJSONObject: json, options: options)
        if let string = String(data: data, encoding: .utf8) {
            return string
        }
    } catch {
        logError("JSON 格式化失败: \(error)")
    }
    return "JSON 格式化失败"
}
