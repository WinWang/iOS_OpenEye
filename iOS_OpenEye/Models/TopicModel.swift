//
//  TopicModel.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/20.
//

import Foundation

// MARK: - TopicModel
struct TopicModel: Codable {
    let itemList: [TopicModelItemList]
    let count: Int
    let total: Int
    let nextPageUrl: String
    let adExist: Bool
}

// MARK: - TopicModelItemList
struct TopicModelItemList: BaseItem,Codable {
    var itemType: Int? = 0
    let type: String
    let data: TopicModelItemListData
    let trackingData: JSONAny?
    let tag: JSONAny?
    let id: Int
    let adIndex: Int
    
}

// MARK: - TopicModelItemListData
struct TopicModelItemListData: Codable {
    let dataType: String
    let id: Int
    let title: String
    let description: String
    let image: String
    let actionUrl: String
    let adTrack: [JSONAny]
    let shade: Bool
    let label: TopicModelItemListDataLabel
    let labelList: [JSONAny]
    let header: JSONAny?
    let autoPlay: Bool
}

// MARK: - TopicModelItemListDataLabel
struct TopicModelItemListDataLabel: Codable {
    let text: String
    let card: String
    let detail: JSONAny?
}

