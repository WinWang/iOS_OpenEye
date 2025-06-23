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

// 使用示例:
/*
 // 创建CustomCornerLabel实例
 let cornerLabel = CustomCornerLabel()
 cornerLabel.frame = CGRect(x: 20, y: 100, width: 200, height: 40)
 cornerLabel.text = "圆角标签示例"
 cornerLabel.textAlignment = .center
 cornerLabel.backgroundColor = .orange
 
 // 设置不同角的圆角半径
 cornerLabel.cornerRadii.topLeft = 10
 cornerLabel.cornerRadii.bottomRight = 10
 
 // 添加到视图
 view.addSubview(cornerLabel)
 */
