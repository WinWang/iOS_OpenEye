//
//  HomeModel.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/3.
//

import Foundation

// MARK: - HomeModel

struct HomeModel: Codable {
    let issueList, itemList: [HomeModelIssueList]?
    let nextPageUrl: String?
    let nextPublishTime: Int?
    let newestIssueType: String?
}

// MARK: - HomeModelIssueList

struct HomeModelIssueList: Codable {
    let releaseTime: Int?
    let type: String?
    let date: Int?
    let publishTime: Int?
    let itemList: [HomeModelIssueListItemList]?
    let count: Int?
}

// MARK: - HomeModelIssueListItemList

struct HomeModelIssueListItemList: Codable {
    let type: String?
    let data: HomeModelIssueListItemListData?
    let id: Int?
    let adIndex: Int?
    let bannerList: [HomeModelIssueListItemList]?
}

// MARK: - HomeModelIssueListItemListData

struct HomeModelIssueListItemListData: Codable {
    let dataType: String?
    let id: Int?
    let title, description, image, actionUrl: String?
    let shade, autoPlay: Bool?
    let cover: CoverModel?
    let playUrl: String?
    let author: AuthorModel?
}

// MARK: - AuthorModel

struct AuthorModel: Codable {
    let id: Int
    let icon, name, description, link: String
    let latestReleaseTime, videoNum: Int
    let adTrack: JSONAny?
    let follow: RootObjectFollow?
    let shield: RootObjectShield?
    let approvedNotReadyVideoCount: Int?
    let ifPgc: Bool?
    let recSort: Int?
    let expert: Bool?
}

// MARK: - RootObjectFollow

struct RootObjectFollow: Codable {
    let itemType: String?
    let itemId: Int?
    let followed: Bool?
}

// MARK: - RootObjectShield

struct RootObjectShield: Codable {
    let itemType: String?
    let itemId: Int?
    let shielded: Bool?
}

// MARK: - CoverModel

struct CoverModel: Codable {
    let feed, detail, blurred, homepage: String?
    let sharing: JSONAny?
}

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
