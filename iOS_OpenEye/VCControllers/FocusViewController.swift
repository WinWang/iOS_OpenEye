//
//  FocusViewController.swift
//  iOS_OpenEye 关注列表
//
//  Created by WinWang on 2025/6/19.
//
import UIKit
import SnapKit
import Then
import JXSegmentedView
import MJRefresh

class FocusViewController :BaseViewController<FocusVewModel>,JXSegmentedListContainerViewListDelegate{
    
    // 列表
    private lazy var tableView = UITableView().then{
        $0.separatorStyle = .none
        $0.delegate = focusAdapter
        $0.dataSource = focusAdapter
    }
    //TableAdapter
    private lazy var focusAdapter = BaseTableViewAdapter()

    //JXSegmentedListContainerViewListDelegate 代理返回数据类型
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
    }
    
    override func initData() {
       
    }
    
    /// 初始化下来刷新--上拉加载
    private func initRefreshLayout(){
        tableView.mj_header = MJRefreshNormalHeader(){[weak self] in
            
        }
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(){[weak self] in
            
        }
    }
}
