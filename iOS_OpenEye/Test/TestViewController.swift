//
//  TestViewController.swift
//  iOS_OpenEye
//
//  测试页面
//
//  Created by WinWang on 2025/5/29.
//
import Kingfisher
import SnapKit
import UIKit

class TestViewController: BaseViewController<BaseViewModel> {
    // 标题栏
    private lazy var titleBar = {
        let titleBar = CommonTitleBar()
        titleBar.setTitle("测试功能集合")
        return titleBar
    }()

    // 容器View
    private lazy var stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    // ScrollView
    private lazy var scrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    // CollectionView按钮
    private lazy var collectionViewButton = createButton("CollectionView", action: #selector(goToCollectionViewPage))
    private lazy var refreshButton = createButton("MJRefresh", action: #selector(goToRefreshPage))
    private lazy var toastButton = createButton("Toast") { [weak self] _ in
        showToast("测试Toast输出")
    }

    private lazy var logDebugButton = createButton("LogDebug") { [weak self] _ in
        logDebug("测试日志输出")
    }

    // StateLayout页面的Button
    private lazy var stateLayoutButton = createButton("StateLayout") { [weak self] _ in
        Router.shared.push(RoutePath.statePage)
    }

    override func initView() {
        addTitleBar(titleBar)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        // 添加所有按钮到 stackView
        for item in [collectionViewButton, refreshButton, toastButton, logDebugButton, stateLayoutButton] {
            stackView.addArrangedSubview(item)
        }
        // 设置完整的约束
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleBar.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        // 确保 stackView 内容宽度与 scrollView 一致
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
    }

    override func initData() {}

    // 跳转CollectionView页面
    @objc private func goToCollectionViewPage() {
//        Router.shared.push(.detail(id: "详情页"))
        Router.shared.push(.collectionView)
    }

    // 跳转下拉刷新页面
    @objc private func goToRefreshPage() {
        Router.shared.push(.refresh)
    }
}
