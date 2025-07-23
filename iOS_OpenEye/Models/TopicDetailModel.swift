import Foundation

struct TopicDetailModel: Codable {
    var id: Int?
    var headerImage: String?
    var brief: String?
    var text: String?
    var shareLink: String?
    var itemList: [TopicDetailModelItemList]?
    var count: Int?
    var adTrack: JSONAny?
}

struct TopicDetailModelItemList: BaseItem,Codable {
    var itemType: Int?
    var type: String?
    var data: TopicDetailModelItemListData?
    var trackingData: JSONAny?
    var tag: JSONAny?
    var id: Int?
    var adIndex: Int?
}

struct TopicDetailModelItemListData: Codable {
    var dataType: String?
    var header: TopicDetailModelItemListDataHeader?
    var content: TopicDetailModelItemListDataContent?
    var adTrack: [JSONAny]?
}

struct TopicDetailModelItemListDataHeader: Codable {
    var id: Int?
    var actionUrl: String?
    var labelList: JSONAny?
    var icon: String?
    var iconType: String?
    var time: Int?
    var showHateVideo: Bool?
    var followType: String?
    var tagId: Int?
    var tagName: JSONAny?
    var issuerName: String?
    var topShow: Bool?
}

struct TopicDetailModelItemListDataContent: Codable {
    var type: String?
    var data: TopicDetailModelItemListDataContentData?
    var trackingData: JSONAny?
    var tag: JSONAny?
    var id: Int?
    var adIndex: Int?
}

struct TopicDetailModelItemListDataContentData: Codable {
    var dataType: String?
    var id: Int?
    var title: String?
    var description: String?
    var library: String?
    var tags: [TopicDetailModelItemListDataContentDataTags]?
    var consumption: TopicDetailModelItemListDataContentDataConsumption?
    var resourceType: String?
    var slogan: JSONAny?
    var provider: TopicDetailModelItemListDataContentDataProvider?
    var category: String?
    var author: TopicDetailModelItemListDataContentDataAuthor?
    var cover: TopicDetailModelItemListDataContentDataCover?
    var playUrl: String?
    var thumbPlayUrl: JSONAny?
    var duration: Int?
    var webUrl: TopicDetailModelItemListDataContentDataWebUrl?
    var releaseTime: Int?
    var playInfo: [TopicDetailModelItemListDataContentDataPlayInfo]?
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
    var videoPosterBean: JSONAny?
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

struct TopicDetailModelItemListDataContentDataTags: Codable {
    var id: Int?
    var name: String?
    var actionUrl: String?
    var adTrack: JSONAny?
    var desc: JSONAny?
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

struct TopicDetailModelItemListDataContentDataConsumption: Codable {
    var collectionCount: Int?
    var shareCount: Int?
    var replyCount: Int?
    var realCollectionCount: Int?
}

struct TopicDetailModelItemListDataContentDataProvider: Codable {
    var name: String?
    var alias: String?
    var icon: String?
}

struct TopicDetailModelItemListDataContentDataAuthor: Codable {
    var id: Int?
    var icon: String?
    var name: String?
    var description: String?
    var link: String?
    var latestReleaseTime: Int?
    var videoNum: Int?
    var adTrack: JSONAny?
    var follow: TopicDetailModelItemListDataContentDataAuthorFollow?
    var shield: TopicDetailModelItemListDataContentDataAuthorShield?
    var approvedNotReadyVideoCount: Int?
    var ifPgc: Bool?
    var recSort: Int?
    var expert: Bool?
}

struct TopicDetailModelItemListDataContentDataAuthorFollow: Codable {
    var itemType: String?
    var itemId: Int?
    var followed: Bool?
}

struct TopicDetailModelItemListDataContentDataAuthorShield: Codable {
    var itemType: String?
    var itemId: Int?
    var shielded: Bool?
}

struct TopicDetailModelItemListDataContentDataCover: Codable {
    var feed: String?
    var detail: String?
    var blurred: String?
    var sharing: JSONAny?
    var homepage: JSONAny?
}

struct TopicDetailModelItemListDataContentDataWebUrl: Codable {
    var raw: String?
    var forWeibo: String?
}

struct TopicDetailModelItemListDataContentDataPlayInfo: Codable {
    var height: Int?
    var width: Int?
    var urlList: [TopicDetailModelItemListDataContentDataPlayInfoUrlList]?
    var name: String?
    var type: String?
    var url: String?
}

struct TopicDetailModelItemListDataContentDataPlayInfoUrlList: Codable {
    var name: String?
    var url: String?
    var size: Int?
}
