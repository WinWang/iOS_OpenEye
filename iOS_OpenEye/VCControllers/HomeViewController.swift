//
//  HomeViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/22.
//
import Kingfisher
import SnapKit
import UIKit

class HomeViewController: BaseViewController {
    // 标题栏
    private lazy var titleBar = {
        let titleBar = CommonTitleBar()
        titleBar.setBackButtonVisibility(false)
        titleBar.setTitle("首页")
        return titleBar
    }()



    override func initView() {
        addTitleBar(titleBar)
    }

    override func initData() {}
    
}
