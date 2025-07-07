import SnapKit
import UIKit
import Then

//
//  TitleBar.swift 通用标题栏
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/26.

class CommonTitleBar: UIView {
    // 内容容器视图
    private lazy var contentView: UIView = UIView()
    //背景容器-主要是为了处理背景alpha
    private lazy var bgContentView = UIView()

    // 状态栏视图
    private lazy var statusBarView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        // 仅作参考
//        view.snp.makeConstraints { make in
//            make.height.equalTo(UIApplication.shared.statusBarFrame.height) // 高度约束
//        }
        return view
    }()

    // 返回按钮
    private lazy var backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "back_icon"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return btn
    }()

    // 标题标签
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    // 右侧容器
    private lazy var rightStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        return stack
    }()

    /// 返回按钮点击动作
    var backHandler: NoParamUnitAction?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStatusBar()
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateStatusBarHeight()
    }

    private func setupUI() {
        //backgroundColor = .appPrimary
        statusBarView.backgroundColor = .appPrimary
        bgContentView.backgroundColor = .appPrimary
        addSubview(bgContentView)
        addSubview(contentView)
        contentView.addSubview(backButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightStack)
        // 内容容器约束
        contentView.snp.makeConstraints {
            $0.top.equalTo(statusBarView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(44) // 固定内容区域高度
        }
        //背景关联
        bgContentView.snp.makeConstraints{
            $0.edges.equalTo(contentView.snp.edges)
        }
        // 原有控件约束调整
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        rightStack.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
    }

    // 配置方法
    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    // 右侧添加View
    func addRightViews(_ rightItems: [UIView] = []) {
        rightItems.forEach { rightStack.addArrangedSubview($0) }
    }

    // 设置返回按钮是否可见
    func setBackButtonVisibility(_ isVisible: Bool) {
        backButton.isHidden = !isVisible
    }

    // 设置titleBar背景颜色
    func setBackgroundColor(_ color: UIColor) {
        statusBarView.backgroundColor = color
        bgContentView.backgroundColor = color
    }
    
    func setTitleBarAlpha(alpha:CGFloat){
        statusBarView.alpha = alpha
        bgContentView.alpha = alpha
    }

    // 设置标题属性
    func setTitleConfig(_ title: String, rightItems: [UIView] = [], showBackButton: Bool = true) {
        titleLabel.text = title
        backButton.isHidden = showBackButton
        rightItems.forEach { rightStack.addArrangedSubview($0) }
    }

    /// 返回按钮操作
    @objc private func backAction() {
        if let handler = backHandler {
            handler()
        } else {
            Router.shared.pop()
        }
    }

    private func setupStatusBar() {
        addSubview(statusBarView)
        statusBarView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.top)
        }
    }

    // 更新状态栏高度
    private func updateStatusBarHeight() {
        let statusBarHeight = window?.safeAreaInsets.top ?? 0
        statusBarView.snp.makeConstraints { make in
            make.height.equalTo(statusBarHeight)
        }
    }
}
