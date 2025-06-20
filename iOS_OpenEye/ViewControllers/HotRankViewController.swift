//
//  HotRankViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/20.
//
import JXSegmentedView
import UIKit
import Then
import SnapKit

class HotRankViewController : BaseViewController<HotRankViewModel>,JXSegmentedListContainerViewListDelegate{

    private let rankType: String
    
    func listView() -> UIView {
        return view
    }
    
    init(rankType: String) {
        self.rankType = rankType
        super.init(nibName: nil, bundle: nil)
    }
    
    
    // 列表
    private lazy var tableView = UITableView().then{
        $0.separatorStyle = .none
        $0.delegate = rankAdapter
        $0.dataSource = rankAdapter
    }
    
    //TableAdapter
    private lazy var rankAdapter = BaseTableViewAdapter<HomeModelIssueListItemList>()
    
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initView() {
        view.addSubview(stateLayout)
        stateLayout.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        stateLayout.addContentView(tableView){
            $0.edges.equalToSuperview()
        }
        rankAdapter.register(cellType: HomeNewItemCell.self, forItemType: HomeItemType.list)
        rankAdapter.bindTableView(tableView)
    }
    
    override func initData() {
        viewModel.getRankList(rankType: rankType)
    }
    
    override func initObserver() {
        super.initObserver()
        subscribe(viewModel.$rankList){ [weak self] rankList in
            self?.rankAdapter.setNewData(rankList)
        }
    }
}
