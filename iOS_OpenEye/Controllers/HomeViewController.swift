//
//  HomeViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/22.
//
import Kingfisher
import UIKit
import SnapKit

class HomeViewController: BaseViewController {
    // 文字标签
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "首页"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func initView() {
        view.backgroundColor = .systemBackground
        title = "首页"
        view.addSubview(titleLabel)
    }

    override func initData() {}

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
