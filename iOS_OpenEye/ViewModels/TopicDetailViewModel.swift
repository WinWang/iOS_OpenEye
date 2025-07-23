//
//  TopicDetailViewModel.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/7/8.
//

import Combine

class TopicDetailViewModel: BaseViewModel {
    // 详情模型
    @Published
    public var topicDetail: TopicDetailModel? = nil

    // 请求专题详情接口
    public func getTopicDetailList(id: Int) {
        httpRequest(ApiManager.shared.openEyeService.getTopicDetailList(id: id)) { [weak self] result in
            self?.topicDetail = result
        }
    }
}
