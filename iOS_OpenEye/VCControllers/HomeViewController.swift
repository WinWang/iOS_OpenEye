//
//  HomeViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/22.
//
import Kingfisher
import SnapKit
import Then
import UIKit

class HomeViewController: BaseViewController<HomeViewModel> {
    // 标题栏
    private lazy var titleBar = CommonTitleBar().then {
        $0.setBackButtonVisibility(false)
        $0.setTitle("首页")
    }

    private lazy var text = UILabel().then {
        $0.text = "测试"
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .appPrimary
    }

    override func initView() {
        addTitleBar(titleBar)
        view.addSubview(stateLayout)
        stateLayout.snp.makeConstraints {
            $0.top.equalTo(titleBar.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        let contentView = UIView()
        stateLayout.addContentView(contentView) {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }
        contentView.addSubview(text)
        text.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
    }

    override func initData() {
        viewModel.getHomeList()
    }

    override func initObserver() {
        super.initObserver()
    }
}
