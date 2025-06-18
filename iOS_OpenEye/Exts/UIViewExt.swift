//
//  UIViewExt.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/16.
//

import UIKit

extension UIView {
    /// 设置圆角-阴影
    /// 模拟 Android CardView 效果，专用于 TableView/CollectionView Cell 场景
    func cardView(
        cornerRadius: CGFloat = 8.0,
        shadowColor: UIColor = .black,
        shadowOpacity: Float = 0.2,
        shadowOffset: CGSize = CGSize(width: 0, height: 2),
        shadowRadius: CGFloat = 4.0,
        backgroundColor: UIColor = .white,
        borderWidth: CGFloat = 0.0,
        borderColor: UIColor = .clear
    ) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false

        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius

        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor

        // 🔧 性能优化：对静态卡片启用光栅化
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
