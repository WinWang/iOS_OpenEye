//
//  CategoryDetail.swift
//  iOS_OpenEye 分类详情列表详情
//
//  Created by WinWang on 2025/7/5.
//
import Foundation
import Combine

class CategoryDetailViewModel : BaseViewModel{
    // 分页参数
    var pageIndex = 0
    // 列表数据
    @Published
    var categoryList: [HomeModelIssueListItemList] = []
    
    func getCategoryDetailList(id:Int){
        httpRequest(ApiManager.shared.openEyeService.getCategoryDetailList(id: id, pageIndex:pageIndex)){ [weak self] result in
            self?.categoryList = result.itemList ?? []
        }
    }
}
