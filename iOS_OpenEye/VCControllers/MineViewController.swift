import UIKit

//
//  MineViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/23.
//
class MineViewController: BaseViewController {
    // 文字标签
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "我的"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func initView() {
        view.backgroundColor = .systemBackground
        title = "我的"
        view.addSubview(titleLabel)
    }

    override func initData() {}
}
