//
//  UIApplicationExt.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/8/12.
//

import UIKit

extension UIApplication {
    /// 获取当前活跃的keyWindow（兼容iOS 13+多场景）
    var currentKeyWindow: UIWindow? {
        // 从活跃场景中获取keyWindow
        connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first { $0.isKeyWindow }
    }
}
