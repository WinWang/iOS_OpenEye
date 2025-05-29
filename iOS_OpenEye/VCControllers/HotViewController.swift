import UIKit

//
//  HotViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/23.
//

class HotViewController: BaseViewController {
    
    private lazy var titleBar = {
        let titleBar = CommonTitleBar()
        titleBar.setBackButtonVisibility(false)
        titleBar.setTitle("热门")
        return titleBar
    }()
    
    // 文字标签
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "热门"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func initView() {
        addTitleBar(titleBar)
    }

    override func initData() {}
}
