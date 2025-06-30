//
//  DetailViewContraller.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/26.
//

import Foundation
import UIKit
import SnapKit
import Then
import BMPlayer

class VideoDetailViewController: BaseViewController<BaseViewModel> {
    
    //播放器实例
    let player = BMPlayer()
    
    private let id: Int


    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func initView() {
        view.addSubview(player)
        player.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.left.right.equalTo(self.view)
            make.height.equalTo(player.snp.width).multipliedBy(9.0/16.0).priority(750)
        }
        // Back button event
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true { return }
            let _ = self.navigationController?.popViewController(animated: true)
        }
        let asset = BMPlayerResource(url: URL(string: "http://baobab.wdjcdn.com/14525705791193.mp4")!,
                                     name: "风格互换：原来你我相爱")
        player.setVideo(resource: asset)
    }

    override func initData() {
        
    }
    
    override func initObserver() {
        super.initObserver()
    }
}
