//
//  TopicDetailViewController.swift
//  iOS_OpenEye  专题详情页面
//
//  Created by WinWang on 2025/7/8.
//

import Foundation
import SnapKit
import Then
import UIKit

class TopicDetailViewController: BaseViewController<TopicDetailViewModel> {
    // 关联ID
    private var id: Int
    
    // adapter
    private lazy var topicAdapter = BaseTableViewAdapter<TopicDetailModelItemList>()
    
    // tableView
    private lazy var tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.delegate = topicAdapter
        $0.dataSource = topicAdapter
        $0.contentInsetAdjustmentBehavior = .never
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // 标题
    private lazy var titleBar = CommonTitleBar().then {
        $0.setTitleBarAlpha(alpha: 0)
    }
    
    // tableView的HeaderView
    private lazy var headerView = TopicHeaderComponent()
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initView() {
        view.addSubview(stateLayout)
        stateLayout.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stateLayout.addContentView(tableView) {
            $0.edges.equalToSuperview()
        }
        addTitleBar(titleBar)
        initTableView()
    }
    
    override func initData() {
        viewModel.getTopicDetailList(id: id)
    }
    
    override func initObserver() {
        super.initObserver()
        subscribe(viewModel.$topicDetail) { [weak self] detail in
            guard let self = self else { return }
            guard let detail = detail else { return }
            self.headerView.updateHeaderView(detail: detail)
            self.topicAdapter.setNewData(detail.itemList ?? [])
            self.titleBar.setTitle(detail.brief ?? AppConstant.EMPTY)
        }
    }
    
    private func initTableView() {
        tableView.tableHeaderView = headerView
        topicAdapter.register(cellType: TopicDetailCell.self, forItemType: TopicItemType.list)
        topicAdapter.bindTableView(tableView)
        topicAdapter.onScroll = { [weak self] scrollview in
            let scrollY = scrollview.contentOffset.y
            if scrollY>=200 {
                self?.titleBar.setTitleBarAlpha(alpha: 1)
            }else {
                self?.titleBar.setTitleBarAlpha(alpha: scrollY/200)
            }
            self?.scrollPlay()
        }
    }
    
    private func scrollPlay(){
        // 找到最居中的 cell 播放视频
        let visibleCells = tableView.visibleCells.sorted {
            let rect1 = tableView.convert($0.frame, to: nil)
            let rect2 = tableView.convert($1.frame, to: nil)
            return abs(rect1.midY - tableView.center.y) < abs(rect2.midY - tableView.center.y)
        }
        if let centerCell = visibleCells.first as? TopicDetailCell {
             centerCell.playVideo()
         }
    }
    
}
