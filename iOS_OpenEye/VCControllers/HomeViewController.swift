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
    //标题栏
    private lazy var titleBar = {
        let titleBar = CommonTitleBar()
        titleBar.setBackButtonVisibility(false)
        titleBar.setTitle("首页")
        return titleBar
    }()

    // 文字标签
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "首页"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapTitleView))
        label.addGestureRecognizer(tapGesture)
        return label
    }()

    override func initView() {
        addTitleBar(titleBar)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(200)
        }
    }

    override func initData() {}

    @objc private func tapTitleView() {
        Router.shared.push(.detail(id: "详情页"))
    }
}
