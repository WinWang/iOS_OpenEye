//
//  VideoPlayerManager.swift
//  iOS_OpenEye 播放器管理类
//
//  Created by WinWang on 2025/8/11.
//
import BMPlayer
import UIKit

class VideoPlayerManager: NSObject {
    static let shared = VideoPlayerManager()
    override private init() {}

    // 全屏容器窗口
    private var fullscreenWindow: UIWindow?
    // 记录当前播放器
    private var currentPlayer: BMPlayer?
    // 记录播放器原来的父视图和约束
    private weak var originalSuperview: UIView?
    // 记录播放状态
    private var isPlayingBeforeFullscreen = false
    // 保存播放器原始尺寸和位置信息（用于SnapKit恢复）
    private var originalFrame: CGRect?
    // 保存播放器的布局信息（用于恢复约束）
    private var originalLayout: (() -> Void)?
    
    // 进入全屏
    func enterFullscreen(with player: BMPlayer, originalLayout: @escaping () -> Void) {
        // 保存当前状态
        currentPlayer = player
        originalSuperview = player.superview
        isPlayingBeforeFullscreen = player.isPlaying
        self.originalLayout = originalLayout
            
        // 暂停播放
        player.pause()
            
        // 从父视图移除播放器
        player.removeFromSuperview()
            
        // 创建全屏窗口
        fullscreenWindow = UIWindow(frame: UIScreen.main.bounds)
        fullscreenWindow?.windowLevel = UIWindow.Level.alert + 1
        fullscreenWindow?.backgroundColor = .black
        fullscreenWindow?.makeKeyAndVisible()
            
        // 添加播放器到全屏窗口
        fullscreenWindow?.addSubview(player)
            
        // 设置全屏约束（使用SnapKit）
        player.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
            
        // 强制布局更新
        fullscreenWindow?.layoutIfNeeded()
            
        // 旋转设备方向为横屏
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
            
        // 继续播放
        player.play()
    }
        
    // 退出全屏
    func exitFullscreen() {
        guard let player = currentPlayer, let superview = originalSuperview, let originalLayout = originalLayout else { return }
            
        // 暂停播放
        player.pause()
            
        // 移除播放器
        player.removeFromSuperview()
            
        // 将播放器添加回原来的父视图
        superview.addSubview(player)
            
        // 恢复原来的约束（使用SnapKit）
        originalLayout()
            
        // 强制布局更新
        superview.layoutIfNeeded()
            
        // 重置设备方向为竖屏
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
            
        // 恢复播放状态
        if isPlayingBeforeFullscreen {
            player.play()
        }
            
        // 清理全屏窗口
        fullscreenWindow?.isHidden = true
        fullscreenWindow = nil
        currentPlayer = nil
        self.originalLayout = nil
    }
        
    // 检查是否处于全屏状态
    func isFullscreen() -> Bool {
        return fullscreenWindow != nil && currentPlayer != nil
    }
}
