//
//  UIViewControllerExt.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/27.
//

import SnapKit
import UIKit

extension UIViewController {
    // 添加标题栏目
    func addTitleBar(_ titleBar: CommonTitleBar) {
        view.addSubview(titleBar)
        titleBar.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }

    // 基于Selector实现
    func createButton(_ title: String, buttonColor: UIColor = .appPrimary, action: Selector? = nil) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.snp.makeConstraints {
            $0.height.equalTo(45)
        }
        if let action = action { button.addTarget(self, action: action, for: .touchUpInside) }

        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = buttonColor
            config.baseForegroundColor = .white
            config.cornerStyle = .medium
            config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            button.configuration = config
        } else {
            button.backgroundColor = buttonColor
            button.layer.borderWidth = 2.0
            button.layer.borderColor = buttonColor.cgColor
            button.layer.cornerRadius = 8.0
            button.layer.masksToBounds = true
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        return button
    }

    // 基于UIAction实现--方法重载
    func createButton(
        _ title: String,
        buttonColor: UIColor = .appPrimary,
        handler: OneParamUnitAction<UIButton>? = nil
    ) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.snp.makeConstraints {
            $0.height.equalTo(45)
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        if let handler = handler {
            button.addAction(UIAction { action in
                handler(action.sender as! UIButton)
            }, for: .touchUpInside)
        }

        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = buttonColor
            config.baseForegroundColor = .white
            config.cornerStyle = .medium
            config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            button.configuration = config
        } else {
            button.backgroundColor = buttonColor
            button.layer.borderWidth = 2.0
            button.layer.borderColor = buttonColor.cgColor
            button.layer.cornerRadius = 8.0
            button.layer.masksToBounds = true
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        return button
    }
}
