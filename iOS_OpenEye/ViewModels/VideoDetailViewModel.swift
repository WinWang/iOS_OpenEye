//
//  VideoDetailViewModel.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/22.
//

import Foundation
import Combine

class VideoDetailViewModel : BaseViewModel{

    @Published
    var relationList: [HomeModelIssueListItemList] = []
    
    ///获取关联列表
    func getVideoRelationList(relationID:Int){
        httpRequest(
            ApiManager.shared.openEyeService.getRelationInfo(id: relationID),
            success: { [weak self] result in
                let filterList = result.itemList?.filter{$0.type == "videoSmallCard"} ?? []
                self?.relationList = filterList
            },
            error: {error in
                logDebug("网络请求错误\(String(describing: error.errorDescription))")
            }
        )
    }
    
}
