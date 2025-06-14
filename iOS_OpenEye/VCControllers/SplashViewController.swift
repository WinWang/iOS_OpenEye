//
//  SplashViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/12.
//

import SnapKit
import UIKit

class SplashViewController: BaseViewController<BaseViewModel> {
    private lazy var landingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "landing_image")
        image.contentMode = .scaleAspectFit
        return image
    }()

    override func initView() {
        view.addSubview(landingImage)
        landingImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
    }

    override func initData() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                Router.shared.replaceMainController()
                logDebug("跳转首页")
            }
        }
    }
}
