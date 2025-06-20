//
//  HotRankViewModel.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/20.
//

import Foundation

class HotRankViewModel : BaseViewModel{
    
    // 列表数据
    @Published
    var rankList: [HomeModelIssueListItemList] = []
    
    public func getRankList(rankType:String){
        httpRequest(
            ApiManager.shared.openEyeService.getRankList(rankType: rankType)
        ) { [weak self] result in
            let items = result.itemList ?? []
            self?.rankList = items
            logDebug("列表长度\(items.count)")
        }
    }
}
