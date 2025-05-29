import UIKit

//
//  UIViewControllerExt.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/27.
//

extension UIViewController {
    // 添加标题栏目
    func addTitleBar(_ titleBar: CommonTitleBar) {
        view.addSubview(titleBar)
        titleBar.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }
}
