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
import MJRefresh

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
    
    //初始化UI
    override func initView() {
        view.addSubview(stateLayout)
        stateLayout.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stateLayout.addContentView(tableView){
            $0.edges.equalToSuperview()
        }
        stateLayout.retryCallback = { [weak self] in
            self?.viewModel.pageIndex = 0
            self?.viewModel.getTopicList()
        }
        initTableView()
    }
    
    //初始化数据加载
    override func initData() {
        viewModel.getTopicList()
    }
    
    //初始化观察者
    override func initObserver() {
        super.initObserver()
        subscribe(viewModel.$topicList){[weak self] topicList in
            if self?.viewModel.pageIndex==0{
                self?.adapter.setNewData(topicList)
            }else{
                self?.adapter.addData(topicList)
            }
            self?.tableView.mj_header?.endRefreshing()
            self?.tableView.mj_footer?.endRefreshing()
        }
    }
    
    // 初始化TableView
    private func initTableView(){
        adapter.register(cellType: TopicItemCell.self, forItemType: 0)
        adapter.bindTableView(tableView)
        adapter.onItemClick = { (index,item) in
            let id = item.data.id
            Router.shared.push(.topicDetail(id: id))
        }
        tableView.mj_header = MJRefreshNormalHeader(){ [weak self] in
            self?.viewModel.pageIndex = 0
            self?.viewModel.getTopicList()
        }
        tableView.mj_footer = MJRefreshAutoNormalFooter(){[weak self] in
            self?.viewModel.pageIndex += self?.adapter.dataList.count ?? 0
            self?.viewModel.getTopicList()
        }
    }
}
