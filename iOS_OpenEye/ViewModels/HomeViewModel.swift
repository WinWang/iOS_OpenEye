//
//  HomeViewModel.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/23.
//

import Combine

class HomeViewModel: BaseViewModel {
    func getHomeList() {
        httpRequest(
            ApiManager.shared.openEyeService.getHomeList(data: ""),
            success: { [weak self] homeModel in
                logDebug("首页数据->\(homeModel)")
            },
            error: { error in
                logDebug("网络请求错误\(error.errorDescription)")
            }
        )

        /// 闭包简单写法
//        httpRequest(
//            ApiManager.shared.openEyeService.getHomeList(data: "")
//        ) { [weak self] homeModel in
//            logDebug("首页数据->\(homeModel)")
//        }
    }
}
