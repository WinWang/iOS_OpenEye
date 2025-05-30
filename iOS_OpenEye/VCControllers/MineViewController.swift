import UIKit

//
//  MineViewController.swift
//  iOS_OpenEye     我的页面
//
//  Created by WinWang on 2025/5/23.
//
class MineViewController: BaseViewController {
    // avator图片链接
    private let avatorUrl = "https://b0.bdstatic.com/ugc/fC2JcRbgBKl5PFCYkULyoA41673a378a2369741a3c3abcc30b57e2.jpg@h_1280"

    // 名字label
    private lazy var userNameLabel = {
        let label = UILabel()
        label.text = "iOS-OpenEye"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()

    // 按钮
    private lazy var homeButton = {
        let button = UIButton()
        button.setTitle("跳转测试", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        // 设置背景色（默认状态）
        button.backgroundColor = UIColor.appPrimary
        // 设置边框和圆角
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.appPrimary.cgColor
        button.layer.cornerRadius = 8.0
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 整体内边距
        return button
    }()

    // 顶部图片
    private lazy var headImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "back_mine")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    // Avator图片
    private lazy var avatorImage = {
        let image = UIImageView()
        return image
    }()

    override func initView() {
        view.addSubview(headImage)
        view.addSubview(userNameLabel)
        view.addSubview(avatorImage)
        view.addSubview(homeButton)
        // 背景图片
        headImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(300)
        }
        // 头像
        avatorImage.snp.makeConstraints {
            $0.center.equalTo(headImage.snp.center)
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
        // 名字
        userNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(avatorImage.snp.bottom).offset(10)
        }

        // 按钮
        homeButton.snp.makeConstraints { make in
            make.top.equalTo(headImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
        }
    }

    override func initData() {
        avatorImage.loadRoundedImage(avatorUrl, radius: 30)
    }

    // 点击事件
    @objc private func tapButton() {
        Router.shared.push(.test)
    }
}
