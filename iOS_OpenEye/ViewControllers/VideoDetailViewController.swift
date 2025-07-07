//
//  DetailViewContraller.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/26.
//

import BMPlayer
import Foundation
import SnapKit
import Then
import UIKit

class VideoDetailViewController: BaseViewController<BaseViewModel> {
    // 播放器实例
    let player = BMPlayer()

    // 关联ID
    private var relationID: Int

    // 视频播放连接
    private var playUrl: String

    // 列表ListViewController
    private lazy var listViewController = VideoListViewController().then {
        $0.relationID = relationID
        $0.itemClickCallback = { [weak self] playUrl in
            self?.updatePlayUrl(playUrl)
        }
    }

    init(id: Int, playUrl: String) {
        self.relationID = id
        self.playUrl = playUrl
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func initView() {
        view.addSubview(player)
        player.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.left.right.equalTo(view)
            $0.height.equalTo(300)
        }
        // 返回按钮
        player.backBlock = { [unowned self] isFullScreen in
            if isFullScreen == true { return }
            let _ = self.navigationController?.popViewController(animated: true)
        }
        // 添加列表容器VC
        addChild(listViewController)
        view.addSubview(listViewController.view)
        // 约束子VC
        listViewController.view.snp.makeConstraints {
            $0.top.equalTo(player.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        listViewController.didMove(toParent: self)
    }

    override func initData() {
        updatePlayUrl(playUrl)
    }

    override func initObserver() {
        super.initObserver()
    }

    // 屏幕旋转监听
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _ in
            guard let self = self else { return }
            let isPortrait = size.height > size.width // 高度大于宽度就是竖屏
            self.listViewController.view.isHidden = !isPortrait
            self.player.snp.remakeConstraints {
                $0.top.equalTo(self.view)
                $0.left.right.equalTo(self.view)
                if isPortrait {
                    $0.height.equalTo(300)
                }else{
                    $0.height.equalTo(self.player.snp.width).multipliedBy(9.0 / 16.0).priority(750)
                }
            }
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      // If use the slide to back, remember to call this method
      // 使用手势返回的时候，调用下面方法
      player.pause(allowAutoPlay: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // If use the slide to back, remember to call this method
        // 使用手势返回的时候，调用下面方法
        player.autoPlay()
      }
    

    /// 更新播放器播放地址
    private func updatePlayUrl(_ playUrl: String) {
        let asset = BMPlayerResource(url: URL(string: playUrl)!, name: AppConstant.EMPTY)
        player.setVideo(resource: asset)
    }
    
    deinit {
      // If use the slide to back, remember to call this method
      // 使用手势返回的时候，调用下面方法手动销毁
      player.prepareToDealloc()
    }
}
