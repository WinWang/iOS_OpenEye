//
//  OpenEyeApi.swift
//  iOS_OpenEye
//  开眼API定义
//  Created by WinWang on 2025/6/3.
//

import Foundation
import Moya

enum OpenEyeApi {
    case home(data: String)
    case focus(pageIndex: Int)
    case category
    case topic(pageIndex: Int)
    case rank(rankType: String)
    case relation(id: Int)
    case categoryDetail(id: Int, pageIndex: Int)
    case topicDetail(id:Int)
}

extension OpenEyeApi: TargetType {
    var baseURL: URL {
        return URL(string: NetConfig.BASE_URL)!
    }

    var path: String {
        switch self {
        case .home:
            return "api/v2/feed"
        case .focus:
            return "api/v4/tabs/follow"
        case .category:
            return "api/v4/categories"
        case .topic:
            return "api/v3/specialTopics"
        case .rank:
            return "api/v4/rankList/videos"
        case .relation:
            return "api/v4/video/related"
        case .categoryDetail:
            return "api/v4/categories/videoList"
        case .topicDetail(let id):
            return "api/v3/lightTopics/internal/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .home,
             .focus,
             .category,
             .topic,
             .rank,
             .relation,
             .topicDetail,
             .categoryDetail:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .home(let data):
            return .requestParameters(parameters: ["date": data, "num": 1], encoding: URLEncoding.queryString)
        case .focus(let pageIndex):
            return .requestParameters(parameters: ["start": pageIndex], encoding: URLEncoding.queryString)
        case .category:
            return .requestPlain
        case .topicDetail:
            return .requestPlain
        case .rank(let rankType):
            return .requestParameters(parameters: ["strategy": rankType], encoding: URLEncoding.queryString)
        case .topic(let pageIndex):
            return .requestParameters(parameters: ["start": pageIndex], encoding: URLEncoding.queryString)
        case .relation(let id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.queryString)
        case .categoryDetail(let id, let pageIndex):
            return .requestParameters(parameters: [
                "id": id, "start": pageIndex, "udid": AppConstant.UUID, "deviceModel": AppConstant.DEVICE_NUM
            ], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        // 添加公共请求头-根据需要自行添加
        return ["Content-Type": "application/json"]
    }
}
