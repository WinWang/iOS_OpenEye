//
//  CustomCornerLabel.swift
//  iOS_OpenEye 自定义圆角标签
//
//  Created by WinWang on 2025/6/14.
//

import UIKit

class CustomCornerLabel: UILabel {
    // 存储四个角的圆角半径
    var cornerRadii = CornerRadii()
    
    struct CornerRadii {
        var topLeft: CGFloat = 0
        var topRight: CGFloat = 0
        var bottomLeft: CGFloat = 0
        var bottomRight: CGFloat = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerMask()
    }
    
    private func updateCornerMask() {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadii.topLeft, height: cornerRadii.bottomRight))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
