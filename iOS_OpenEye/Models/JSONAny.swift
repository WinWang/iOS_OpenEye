//
//  JSONAny.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/19.
//

// MARK: - 处理任意类型

struct JSONAny: Codable {
    let value: Any

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let value = try? container.decode(String.self) {
            self.value = value
        } else if let value = try? container.decode(Int.self) {
            self.value = value
        } else if let value = try? container.decode(Double.self) {
            self.value = value
        } else if let value = try? container.decode(Bool.self) {
            self.value = value
        } else if let value = try? container.decode([JSONAny].self) {
            self.value = value.map { $0.value }
        } else if let value = try? container.decode([String: JSONAny].self) {
            self.value = value.mapValues { $0.value }
        } else {
            throw DecodingError.typeMismatch(JSONAny.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Failed to decode JSONAny"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch value {
        case let value as String:
            try container.encode(value)
        case let value as Int:
            try container.encode(value)
        case let value as Double:
            try container.encode(value)
        case let value as Bool:
            try container.encode(value)
        case let value as [Any]:
            let codableArray = value.map { JSONAny(value: $0) }
            try container.encode(codableArray)
        case let value as [String: Any]:
            let codableDict = value.mapValues { JSONAny(value: $0) }
            try container.encode(codableDict)
        default:
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Invalid value for JSONAny"))
        }
    }

    init(value: Any) {
        self.value = value
    }
}
