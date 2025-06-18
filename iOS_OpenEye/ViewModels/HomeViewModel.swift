//
//  HomeViewModel.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/23.
//

import Combine
import Foundation

class HomeViewModel: BaseViewModel {
    // 分页参数
    var date = AppConstant.EMPTY

    // 列表数据
    @Published
    var homeList: [HomeModelIssueListItemList] = []

    func getHomeList() {
        httpRequest(
            ApiManager.shared.openEyeService.getHomeList(data: ""),
            showStateLoading: date == AppConstant.EMPTY,
            showStateError: date != AppConstant.EMPTY
        ) { [weak self] result in
            let items = result.issueList?.first?.itemList ?? []
            var list = items.filter { $0.type == "video" }
            list.map{
                var item = $0
                item.itemType = HomeItemType.list
                return item
            }
            if self?.date == AppConstant.EMPTY {
//                var bannerList: [HomeModelIssueListItemList] = []
//                var bannerData = HomeModelIssueListItemList( itemType:HomeItemType.banner ,type: nil,
//                                                            data: nil,
//                                                            id: nil,
//                                                            adIndex: nil,
//                                                            bannerList: nil)
//                let tempBannerList = items.filter { $0.type == "banner2" }
//                bannerList.append(contentsOf: tempBannerList)
//                if !bannerList.isEmpty {
//                    bannerData.bannerList = bannerList
//                    bannerData.type = "banner"
//                    bannerData.itemType = HomeItemType.banner
//                    list.insert(bannerData, at: 0)
//                }
            }
            if self?.date == AppConstant.EMPTY {
                self?.homeList = list
            } else {
                self?.homeList.append(contentsOf: list)
            }

            self?.splitDate(from: result.nextPageUrl ?? AppConstant.EMPTY)
        }
    }

    /// 切割获取下一页的数据参数
    private func splitDate(from nextUrl: String) {
        guard let urlComponents = URLComponents(string: nextUrl),
              let queryItems = urlComponents.queryItems,
              let firstItem = queryItems.first,
              firstItem.name == "date"
        else {
            return
        }

        date = firstItem.value ?? AppConstant.EMPTY
    }

    // TODO: Demo实例

//    func getHomeList() {
//        httpRequest(
//            ApiManager.shared.openEyeService.getHomeList(data: ""),
//            success: { [weak self] homeModel in
//                logDebug("首页数据->\(homeModel)")
//            },
//            error: { error in
//                logDebug("网络请求错误\(error.errorDescription)")
//            }
//        )
//
//        /// 闭包简单写法
    ////        httpRequest(
    ////            ApiManager.shared.openEyeService.getHomeList(data: "")
    ////        ) { [weak self] homeModel in
    ////            logDebug("首页数据->\(homeModel)")
    ////        }
//    }
}
