//
//  CustomDialog.swift
//  iOS_OpenEye 通用类型弹窗
//
//  Created by WinWang on 2025/8/13.
//

import SnapKit
import UIKit

class CustomDialog: UIView {
    // MARK: - Callbacks

    // 确定按钮
    private var confirmAction: (() -> Void)?
    // 取消按钮
    private var cancelAction: (() -> Void)?
    // 能否点击空白区域消失
    private var tapToDismiss = true
    
    // MARK: - UI Components

    // 容器View
    private let containerView = UIView()
    // 标题文字
    private let titleLabel = UILabel()
    // 内容文字
    private let contentLabel = UILabel()
    // 取消按钮
    private let cancelButton = UIButton(type: .system)
    // 确定按钮
    private let confirmButton = UIButton(type: .system)
    // 顶部分割线
    private let topSeparatorLine = UIView()
    // 分割线
    private let separatorLine = UIView()
    // 垂直分割线
    private let verticalSeparatorLine = UIView()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI

    private func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        // 点击遮罩关闭
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        addGestureRecognizer(tap)
        
        // 容器视图
        addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowRadius = 8
        
        // 添加子视图（顺序不重要，但都要先加）
        containerView.addSubview(titleLabel)
        containerView.addSubview(topSeparatorLine)
        containerView.addSubview(contentLabel)
        containerView.addSubview(separatorLine)
        containerView.addSubview(verticalSeparatorLine)
        containerView.addSubview(cancelButton)
        containerView.addSubview(confirmButton)
        
        // 布局约束
        setupConstraints()
    }
    
    private func setupConstraints() {
        // 容器视图：宽度为屏幕的 80%，居中
        containerView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.center.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(60)
            make.bottom.lessThanOrEqualToSuperview().offset(-60)
        }
        
        // 标题
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        titleLabel.textColor = UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // 顶部分割线
        topSeparatorLine.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        topSeparatorLine.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        // 内容
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        contentLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        contentLabel.textAlignment = .left
        contentLabel.numberOfLines = 0
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(topSeparatorLine.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // 分割线
        separatorLine.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        separatorLine.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        
        verticalSeparatorLine.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        verticalSeparatorLine.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(0.5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        // 按钮
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.addTarget(self, action: #selector(onCancel), for: .touchUpInside)
        cancelButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.top.equalTo(contentLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(50)
        }
        
        confirmButton.setTitle("确定", for: .normal)
        confirmButton.setTitleColor(.appPrimary, for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        confirmButton.addTarget(self, action: #selector(onConfirm), for: .touchUpInside)
        confirmButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.leading.equalTo(cancelButton.snp.trailing)
            make.width.equalTo(cancelButton)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Public Methods

    func setTitle(_ title: String?) -> Self {
        titleLabel.text = title
        titleLabel.isHidden = title == nil
        return self
    }
    
    func setContent(_ content: String?) -> Self {
        contentLabel.text = content
        return self
    }
    
    func showNegativeButton(showButton: Bool) -> Self {
        cancelButton.isHidden = !showButton
        verticalSeparatorLine.isHidden = true
        confirmButton.snp.remakeConstraints { make in
                 make.leading.trailing.bottom.equalToSuperview()
                 make.top.equalTo(contentLabel.snp.bottom).offset(20)
                 make.height.equalTo(50)
             }
        containerView.layoutIfNeeded()
        return self
    }
    
    func showPositiveButton(showButton: Bool) -> Self {
        confirmButton.isHidden = !showButton
        verticalSeparatorLine.isHidden = true
        cancelButton.snp.remakeConstraints { make in
                 make.leading.trailing.bottom.equalToSuperview()
                 make.top.equalTo(contentLabel.snp.bottom).offset(20)
                 make.height.equalTo(50)
             }
        containerView.layoutIfNeeded()
        return self
    }
    
    func setConfirmAction(_ action: @escaping () -> Void) -> Self {
        confirmAction = action
        return self
    }
    
    func setCancelAction(_ action: @escaping () -> Void) -> Self {
        cancelAction = action
        return self
    }
    
    func setTapToDismiss(_ enabled: Bool) -> Self {
        tapToDismiss = enabled
        return self
    }
    
    // MARK: - Actions

    @objc private func onConfirm() {
        dismiss()
        confirmAction?()
    }
    
    @objc private func onCancel() {
        dismiss()
        cancelAction?()
    }
    
    @objc private func dismiss() {
        removeFromSuperview()
    }
}
