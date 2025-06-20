//
//  FocusModel.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/19.
//
import Foundation

struct FocusModel: Codable {
    var itemList: [FocusModelItemList]?
    var count: Int?
    var total: Int?
    var nextPageUrl: String?
    var adExist: Bool?
    var updateTime: JSONAny?
    var refreshCount: Int?
    var lastStartId: Int?
}

struct FocusModelItemList: Codable {
    var type: String?
    var data: FocusModelItemListData?
    var trackingData: JSONAny?
    var tag: JSONAny?
    var id: Int?
    var adIndex: Int?
}

struct FocusModelItemListData: Codable {
    var dataType: String?
    var header: FocusModelItemListDataHeader?
    var itemList: [FocusModelItemListDataItemList]?
    var count: Int?
    var adTrack: JSONAny?
    var footer: JSONAny?
}

struct FocusModelItemListDataHeader: Codable {
    var id: Int?
    var icon: String?
    var iconType: String?
    var title: String?
    var subTitle: JSONAny?
    var description: String?
    var actionUrl: String?
    var adTrack: JSONAny?
    var follow: FocusModelItemListDataHeaderFollow?
    var ifPgc: Bool?
    var uid: Int?
    var ifShowNotificationIcon: Bool?
    var expert: Bool?
}

struct FocusModelItemListDataHeaderFollow: Codable {
    var itemType: String?
    var itemId: Int?
    var followed: Bool?
}

struct FocusModelItemListDataItemList: BaseItem,Codable {
    //多 type类型
    var itemType: Int? = 0
    var type: String?
    var data: FocusModelItemListDataItemListData?
    var trackingData: JSONAny?
    var tag: JSONAny?
    var id: Int?
    var adIndex: Int?
    
    enum CodingKeys: String, CodingKey {
           case type
           case data
           case trackingData
           case tag
           case id
           case adIndex
       }
}

struct FocusModelItemListDataItemListData: Codable {
    var dataType: String?
    var id: Int?
    var title: String?
    var description: String?
    var library: String?
    var tags: [FocusModelItemListDataItemListDataTags]?
    var consumption: FocusModelItemListDataItemListDataConsumption?
    var resourceType: String?
    var slogan: JSONAny?
    var provider: FocusModelItemListDataItemListDataProvider?
    var category: String?
    var author: FocusModelItemListDataItemListDataAuthor?
    var cover: FocusModelItemListDataItemListDataCover?
    var playUrl: String?
    var thumbPlayUrl: JSONAny?
    var duration: Int?
    var webUrl: FocusModelItemListDataItemListDataWebUrl?
    var releaseTime: Int?
    var playInfo: [FocusModelItemListDataItemListDataPlayInfo]?
    var campaign: JSONAny?
    var waterMarks: JSONAny?
    var ad: Bool?
    var adTrack: [JSONAny]?
    var type: String?
    var titlePgc: String?
    var descriptionPgc: String?
    var remark: String?
    var ifLimitVideo: Bool?
    var searchWeight: Int?
    var brandWebsiteInfo: JSONAny?
    // TODO 这里可能返回null,需要兼容null
//    var videoPosterBean: FocusModelItemListDataItemListDataVideoPosterBean?
    var idx: Int?
    var shareAdTrack: JSONAny?
    var favoriteAdTrack: JSONAny?
    var webAdTrack: JSONAny?
    var date: Int?
    var promotion: JSONAny?
    var label: JSONAny?
    var labelList: [JSONAny]?
    var descriptionEditor: String?
    var collected: Bool?
    var reallyCollected: Bool?
    var played: Bool?
    var subtitles: [JSONAny]?
    var lastViewTime: JSONAny?
    var playlists: JSONAny?
    var src: JSONAny?
    var recallSource: JSONAny?
    var recall_source: JSONAny?
    
}

struct FocusModelItemListDataItemListDataTags: Codable {
    var id: Int?
    var name: String?
    var actionUrl: String?
    var adTrack: JSONAny?
    var desc: String?
    var bgPicture: String?
    var headerImage: String?
    var tagRecType: String?
    var childTagList: JSONAny?
    var childTagIdList: JSONAny?
    var haveReward: Bool?
    var ifNewest: Bool?
    var newestEndTime: JSONAny?
    var communityIndex: Int?
}

struct FocusModelItemListDataItemListDataConsumption: Codable {
    var collectionCount: Int?
    var shareCount: Int?
    var replyCount: Int?
    var realCollectionCount: Int?
}

struct FocusModelItemListDataItemListDataProvider: Codable {
    var name: String?
    var alias: String?
    var icon: String?
}

struct FocusModelItemListDataItemListDataAuthor: Codable {
    var id: Int?
    var icon: String?
    var name: String?
    var description: String?
    var link: String?
    var latestReleaseTime: Int?
    var videoNum: Int?
    var adTrack: JSONAny?
    var follow: FocusModelItemListDataItemListDataAuthorFollow?
    var shield: FocusModelItemListDataItemListDataAuthorShield?
    var approvedNotReadyVideoCount: Int?
    var ifPgc: Bool?
    var recSort: Int?
    var expert: Bool?
}

struct FocusModelItemListDataItemListDataAuthorFollow: Codable {
    var itemType: String?
    var itemId: Int?
    var followed: Bool?
}

struct FocusModelItemListDataItemListDataAuthorShield: Codable {
    var itemType: String?
    var itemId: Int?
    var shielded: Bool?
}

struct FocusModelItemListDataItemListDataCover: Codable {
    var feed: String?
    var detail: String?
    var blurred: String?
    var sharing: JSONAny?
    var homepage: JSONAny?
}

struct FocusModelItemListDataItemListDataWebUrl: Codable {
    var raw: String?
    var forWeibo: String?
}

struct FocusModelItemListDataItemListDataPlayInfo: Codable {
    var height: Int?
    var width: Int?
    var urlList: [FocusModelItemListDataItemListDataPlayInfoUrlList]?
    var name: String?
    var type: String?
    var url: String?
}

struct FocusModelItemListDataItemListDataPlayInfoUrlList: Codable {
    var name: String?
    var url: String?
    var size: Int?
}

struct FocusModelItemListDataItemListDataVideoPosterBean: Codable {
    var scale: Int?
    var url: String?
    var fileSizeStr: String?
}


