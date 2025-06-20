//
//  TopicViewModel.swift
//  iOS_OpenEye 主题模块
//
//  Created by WinWang on 2025/6/20.
//

import Foundation

class TopicViewModel :BaseViewModel{
 
    var pageIndex:Int = 0
    
    @Published
    var topicList:[TopicModelItemList] = []
    
    public func getTopicList(){
        httpRequest(
            ApiManager.shared.openEyeService.getTopicList(pageIndex: pageIndex),
            showStateLoading: pageIndex==0,showStateError: pageIndex==0,
            success:  { [weak self]  result in
                self?.topicList = result.itemList
            }
        )
    }
    
}
