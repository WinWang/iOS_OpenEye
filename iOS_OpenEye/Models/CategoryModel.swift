//
//  Untitled.swift
//  iOS_OpenEye  分类数据模型
//
//  Created by WinWang on 2025/6/19.
//

struct CategoryModel: Codable {
    let categoryList: [CategoryModelChild]?
    
    // 自定义解码方式，因为外层是数组
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        categoryList = try container.decode([CategoryModelChild].self)
    }
}

struct CategoryModelChild: BaseItem, Codable {
    // 本地使用的类型标识，不参与解码
    var itemType: Int? = 0
    let id: Int?
    let name: String?
    let alias: String?
    let description: String?
    let bgPicture: String?
    let bgColor: String?
    let headerImage: String?
    let defaultAuthorId: Int?
    let tagId: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, alias, description, bgPicture, bgColor, headerImage, defaultAuthorId, tagId
    }
}
