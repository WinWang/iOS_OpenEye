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

    // 记录当前播放器
    private var currentPlayer: BMPlayer?

    public func setCurrentPlayer(player: BMPlayer?) {
        currentPlayer?.pause()
        currentPlayer = player
    }
}
