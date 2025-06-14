import UIKit

//
//  HotViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/23.
//

class HotViewController: BaseViewController<HotViewModel> {
    // 标题栏
    private lazy var titleBar = CommonTitleBar().then {
        $0.setBackButtonVisibility(false)
        $0.setTitle("热门")
    }

    override func initView() {
        addTitleBar(titleBar)
    }

    override func initData() {}
}
