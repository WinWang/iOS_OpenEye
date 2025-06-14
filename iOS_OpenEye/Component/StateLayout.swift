//
//  StateLayout.swift
//  iOS_OpenEye
//  页面状态展示包裹布局
//
//  Created by WinWang on 2025/5/28.
//

import Combine
import SnapKit
import SwiftUICore
import Then
import UIKit

class StateLayout: UIView {
    // 内容容器
    private let contentContainer = UIView()
    // 占位布局
    private let holdContentContainer = UIView()
    // 占位图片
    private lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    // 占位文字View
    private lazy var textView = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .color_2C2C2C
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    // 重试按钮Button
    private lazy var retryButton = UIButton(type: .system).then {
        $0.backgroundColor = .appPrimary
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 4
        $0.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
    }
    
    // Combine 订阅
    private var cancellables = Set<AnyCancellable>()

    // 图片尺寸
    private var imageWidth: CGFloat = 260
    private var imageHeight: CGFloat = 130

    // MARK: - 公共属性

    var viewState: ViewState = .setViewState() {
        didSet {
            updateUI()
        }
    }

    // 重试按钮
    var retryCallback: NoParamUnitAction?
    var showRetryButton: Bool = true {
        didSet {
            updateUI()
        }
    }

    var showEmptyRetryButton: Bool = true {
        didSet {
            updateUI()
        }
    }

    var paddingTop: CGFloat = 90 {
        didSet {
            updateConstraints()
        }
    }

    var paddingBottom: CGFloat = 0 {
        didSet {
            updateConstraints()
        }
    }

    var contentAlign: Alignment = .center {
        didSet {
            updateConstraints()
        }
    }

    var showTogether: Bool = false {
        didSet {
            updateUI()
        }
    }

    // MARK: - 初始化

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        // 添加内容容器和占位容器
        addSubview(contentContainer)
        addSubview(holdContentContainer)

        // 组合View
        holdContentContainer.addSubview(imageView)
        holdContentContainer.addSubview(textView)
        holdContentContainer.addSubview(retryButton)

        setupConstraints()
    }

    /// - 约束控制
    private func setupConstraints() {
        // 内容容器和占位容器占据整个父视图
        contentContainer.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        holdContentContainer.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        // 占位内容约束 - 初始设置，将在 updateConstraints 中根据对齐方式调整
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(paddingTop)
            $0.width.equalTo(imageWidth)
            $0.height.equalTo(imageHeight)
        }

        textView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        retryButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textView).offset(20)
            $0.height.equalTo(40)
            $0.width.greaterThanOrEqualTo(165)
            $0.bottom.lessThanOrEqualToSuperview().offset(-paddingBottom)
        }
    }

    // 根据对齐方式更新约束
    override func updateConstraints() {
        super.updateConstraints()
        // 这里可以根据 contentAlign 调整占位内容的位置
        switch contentAlign {
        case .top:
            imageView.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(paddingTop)
            }
            retryButton.snp.updateConstraints { make in
                make.bottom.lessThanOrEqualToSuperview().offset(-paddingBottom)
            }

        case .bottom:
            imageView.snp.updateConstraints { make in
                make.top.greaterThanOrEqualToSuperview().offset(50)
            }
            retryButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(-paddingBottom)
            }

        case .center:
            imageView.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(100)
            }
            retryButton.snp.updateConstraints { make in
                make.bottom.lessThanOrEqualToSuperview().offset(-100)
            }

        default:
            break
        }
    }

    // MARK: - 状态更新

    private func updateUI() {
        // 根据状态显示/隐藏内容
        contentContainer.isHidden = viewState.state != .success && !showTogether
        holdContentContainer.isHidden = viewState.state == .success

        if !holdContentContainer.isHidden {
            updateHoldContent()
        }
    }

    private func updateHoldContent() {
        if viewState.state == .customView, let builder = viewState.customView {
            // 清除现有子视图并添加自定义视图
            holdContentContainer.subviews.filter { $0 !== imageView && $0 !== textView && $0 !== retryButton }.forEach { $0.removeFromSuperview() }
            let customView = builder
            holdContentContainer.addSubview(customView)
            customView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        } else {
            // 更新图片
            imageView.image = convertImage()
            imageView.snp.updateConstraints { make in
                make.width.equalTo(imageWidth)
                make.height.equalTo(imageHeight)
            }

            // 更新文本
            textView.text = convertValue()
            textView.isHidden = textView.text?.isEmpty ?? true

            // 更新按钮
            retryButton.setTitle(convertButtonTips(), for: .normal)
            retryButton.isHidden = !showRetryButtonHandler()
        }
    }

    // MARK: - 工具方法

    private func showRetryButtonHandler() -> Bool {
        if viewState.state == .loading || !showRetryButton || convertButtonTips().isEmpty {
            return false
        }
        if viewState.state == .empty && !showEmptyRetryButton {
            return false
        }
        return true
    }

    private func convertButtonTips() -> String {
        switch viewState.state {
        case .loading:
            return "加载中..."
        case .error:
            return "点击重试"
        case .networkError:
            return "点击重试"
        case .empty:
            return "点击重试"
        case .custom:
            return viewState.buttonTips
        default:
            return "加载成功"
        }
    }

    private func convertValue() -> String {
        switch viewState.state {
        case .loading:
            return "加载中..."
        case .error:
            return "加载失败"
        case .networkError:
            return "网络错误"
        case .empty:
            return "暂无数据"
        case .custom:
            return viewState.tips
        default:
            return "加载成功"
        }
    }

    private func convertImage() -> UIImage? {
        switch viewState.state {
        case .loading:
            imageWidth = 100
            imageHeight = 100
            imageView.showGifImage("loading")
            return UIImage()
        case .error:
            imageWidth = 260
            imageHeight = 130
            return UIImage(named: "error")
        case .networkError:
            imageWidth = 260
            imageHeight = 130
            return UIImage(named: "timeout")
        case .empty:
            imageWidth = 260
            imageHeight = 130
            return UIImage(named: "empty")
        case .custom:
            return nil
        default:
            imageWidth = 100
            imageHeight = 100
            return UIImage(named: "loading")
        }
    }

    // 事件处理
    @objc private func retryButtonTapped() {
        retryCallback?()
    }

    // MARK: - 内容管理

    /// 添加内容视图并设置约束
    func addContentView(_ view: UIView, constraints: (ConstraintMaker) -> Void) {
        contentContainer.addSubview(view)
        view.snp.makeConstraints(constraints)
    }

    /// 清除所有内容视图
    func clearContentViews() {
        contentContainer.subviews.forEach { $0.removeFromSuperview() }
    }
}
