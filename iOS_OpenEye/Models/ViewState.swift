//
//  ViewState.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/12.
//

import UIKit

struct ViewState {
    // 页面状态
    var state: ViewStateEnum = .success
    // 描述文案
    var tips: String = AppConstant.EMPTY
    // 按钮文案
    var buttonTips: String = AppConstant.EMPTY
    // 占位Image
    var placeHolder: UIImage?
    // 自定义视图
    var customView: UIView?

    // 默认loading
    static func setViewState() -> ViewState {
        return ViewState(state: .loading)
    }

    // 成功布局
    static func setSuccess() -> ViewState {
        return ViewState(state: .success)
    }

    // 错误布局
    static func setError() -> ViewState {
        return ViewState(state: .error)
    }

    // 网络异常
    static func setNetworkError() -> ViewState {
        return ViewState(state: .networkError)
    }

    // 空占位
    static func setEmpty() -> ViewState {
        return ViewState(state: .empty)
    }

    // 设置自定义图片、文案
    static func setCustom(
        tips: String = AppConstant.EMPTY,
        buttonTips: String = AppConstant.EMPTY,
        placeHolder: UIImage?,
        state: ViewStateEnum = .custom
    ) -> ViewState {
        return ViewState(state: state, tips: tips, buttonTips: buttonTips, placeHolder: placeHolder)
    }
}
