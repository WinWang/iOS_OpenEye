//
//  VideoListViewController.swift
//  iOS_OpenEye    视频列表ViewController
//
//  Created by WinWang on 2025/7/4.
//
import MJRefresh
import SnapKit
import Then
import UIKit

class VideoListViewController: BaseViewController<VideoDetailViewModel> {
    private lazy var listAdapter = BaseTableViewAdapter<HomeModelIssueListItemList>()
    
    private lazy var tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.delegate = listAdapter
        $0.dataSource = listAdapter
    }
    
    public var relationID: Int = 0
    
    public var itemClickCallback: OneParamUnitAction<String>?
    
    override func initView() {
        view.addSubview(stateLayout)
        stateLayout.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stateLayout.addContentView(tableView) {
            $0.edges.equalToSuperview()
        }
        stateLayout.retryCallback = { [weak self] in
            self?.initData()
        }
        initTableView()
    }
    
    override func initData() {
        viewModel.getVideoRelationList(relationID: relationID)
    }
    
    override func initObserver() {
        super.initObserver()
        subscribe(viewModel.$relationList) { [weak self] videoList in
            self?.listAdapter.setNewData(videoList)
            self?.tableView.mj_header?.endRefreshing()
        }
    }
    
    private func initTableView() {
        listAdapter.register(cellType: VideoListCell.self, forItemType: HomeItemType.list)
        listAdapter.onItemClick = { [weak self] _, item in
            self?.itemClickCallback?(item.data?.playUrl ?? AppConstant.EMPTY)
        }
        tableView.mj_header = MJRefreshNormalHeader { [weak self] in
            self?.initData()
        }
        listAdapter.bindTableView(tableView)
    }
    
}
