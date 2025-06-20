//
//  TopicViewController.swift
//  iOS_OpenEye 专题列表
//
//  Created by WinWang on 2025/6/19.
//

import UIKit
import SnapKit
import Then
import JXSegmentedView

class TopicViewController :BaseViewController<TopicViewModel>,JXSegmentedListContainerViewListDelegate{
    
    private lazy var tableView = UITableView().then{
        $0.separatorStyle = .none
        $0.delegate = adapter
        $0.dataSource = adapter
    }
    
    private lazy var adapter = BaseTableViewAdapter<TopicModelItemList>()
    
    func listView() -> UIView {
        return view
    }
    
    override func initView() {
        view.addSubview(stateLayout)
        stateLayout.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stateLayout.addContentView(tableView){
            $0.edges.equalToSuperview()
        }
        stateLayout.retryCallback = { [weak self] in
            self?.viewModel.getTopicList()
        }
        initTableView()
    }
    
    override func initData() {
        viewModel.getTopicList()
    }
    
    override func initObserver() {
        super.initObserver()
        subscribe(viewModel.$topicList){[weak self] topicList in
            self?.adapter.setNewData(topicList)
        }
    }
    
    private func initTableView(){
        adapter.register(cellType: TopicItemCell.self, forItemType: 0)
        adapter.bindTableView(tableView)
    }
}
