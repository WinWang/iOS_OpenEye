//
//  VideoCustomController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/7/10.
//
import BMPlayer
import SnapKit
import UIKit

class VideoCustomController: BMPlayerControlView {
    // 记录播放器原来的父视图和约束
    private weak var originalSuperview: UIView?

    // 初始化时配置约束
    func setupPlayerConstraints(player: BMPlayer, superview: UIView) {
        self.player = player
        // 赋值原始父容器
        originalSuperview = superview
    }

    override func customizeUIComponents() {
        backButton.isHidden = true
    }

    /// 屏幕全屏按钮回调
    override func updateUI(_ isForFullScreen: Bool) {
        backButton.isHidden = !isForFullScreen
        super.updateUI(isForFullScreen)
    }

    override func onButtonPressed(_ button: UIButton) {
        if let type = ButtonType(rawValue: button.tag) {
            switch type {
            case .fullscreen, .back:
                if !isFullscreen {
                    logDebug("全屏->")
                    enterFullScreen()
                } else {
                    exitFullScreen()
                    logDebug("非全屏->")
                }
            default:
                break
            }
        }
        super.onButtonPressed(button)
    }

    /// 打开全屏
    private func enterFullScreen() {
        guard let player = player else { return }
        // 横屏UI更新
        if let window = UIApplication.shared.currentKeyWindow {
            // 移除所有约束
            player.snp.removeConstraints()
            player.removeFromSuperview()
            window.addSubview(player)
            player.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            window.layoutIfNeeded()
        }
    }

    /// 退出全屏
    private func exitFullScreen() {
        guard let player = player,
              let originalSuperview = originalSuperview else { return }
        // 移除所有约束
        player.snp.removeConstraints()
        player.removeFromSuperview()

        // 添加回原始父视图
        originalSuperview.addSubview(player)
        player.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        // 强制更新布局
        originalSuperview.setNeedsLayout()
    }
}
