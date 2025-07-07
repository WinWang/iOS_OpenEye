import UIKit

//
//  MineViewController.swift
//  iOS_OpenEye     我的页面
//
//  Created by WinWang on 2025/5/23.
//
class MineViewController: BaseViewController<MineViewModel> {
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
    
    //测试标签
    private lazy var testSettingView = SettingView().then{
        $0.setTitle("测试集合页面")
        $0.setImageIcon("icon_test")
        $0.clickAction = {
            Router.shared.push(.test)
        }
    }
    
    //关于标签
    private lazy var aboutSettingView = SettingView().then{
        $0.setTitle("关于")
        $0.setImageIcon("icon_about")
        $0.clickAction = {
            Router.shared.push(.test)
        }
    }

    // 顶部图片
    private lazy var headImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "back_mine")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    // Avator图片
    private lazy var avatorImage = UIImageView()

    override func initView() {
        view.isUserInteractionEnabled = true
        view.addSubview(headImage)
        view.addSubview(userNameLabel)
        view.addSubview(avatorImage)
        view.addSubview(testSettingView)
        view.addSubview(aboutSettingView)
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

        //测试按钮
        testSettingView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(headImage.snp.bottom)
        }
        
        //关于按钮
        aboutSettingView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(testSettingView.snp.bottom)
        }
    }

    override func initData() {
        avatorImage.loadRoundedImage(avatorUrl, radius: 30)
    }

}
