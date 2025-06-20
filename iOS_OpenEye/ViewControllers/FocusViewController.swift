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

class FocusViewController :BaseViewController<FocusViewModel>,JXSegmentedListContainerViewListDelegate{
    
    // 列表
    private lazy var tableView = UITableView().then{
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorStyle = .none
        $0.delegate = focusAdapter
        $0.dataSource = focusAdapter
        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = 0 // 或者其他值来调整间距
        }
    }
    //TableAdapter
    private lazy var focusAdapter = BaseTableSectionViewAdapter<FocusModelItemListDataItemList>()

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
        stateLayout.retryCallback = { [weak self] in
            self?.viewModel.getFocusList()
        }
        initTableView()
        initRefreshLayout()
    }
    
    override func initData() {
        viewModel.getFocusList()
    }
    
    override func initObserver() {
        super.initObserver()
        subscribe(viewModel.$focusList){ [weak self] focusList in
            self?.handleFocusData(focusList)
            self?.tableView.mj_header?.endRefreshing()
            self?.tableView.mj_footer?.endRefreshing()
        }
    }
    
    // 初始化TableView
    private func initTableView(){
        // 注册Cell类型
        focusAdapter.register(cellType: FocusItemCell.self, forItemType: 0)
        focusAdapter.bindTableView(tableView)
    }
    
    /// 初始化下来刷新--上拉加载
    private func initRefreshLayout(){
        tableView.mj_header = MJRefreshNormalHeader(){[weak self] in
            self?.viewModel.pageIndex = 0
            self?.viewModel.getFocusList()
        }
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(){[weak self] in
            self?.viewModel.pageIndex+=1
            self?.viewModel.getFocusList()
        }
    }
    
    //处理数据
    private func handleFocusData(_ focusData : [FocusModelItemList]){
        //包装头
        wrapHeaderView(focusData)
        //数据转换
        let sectionList = focusData.map{item in
            return item.data?.itemList ?? []
        }
        if viewModel.pageIndex==0{
            focusAdapter.setNewData(sectionList)
        }else {
            focusAdapter.addData(sectionList)
        }
    }
    
    // 包装头布局
    private func wrapHeaderView(_ focusData : [FocusModelItemList]){
       let sectionStartIndex =  focusAdapter.numberOfSections(in: tableView)
        for index in focusData.indices{
            let item = focusData[index]
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 60))
            headerView.backgroundColor = .color_F2F2F2
//            headerView.backgroundColor = UIColor.gradient(colors: [.color_10FF6900,.transparant], frame: headerView.frame, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
            let avatorView = UIImageView()
            let titleView = UILabel().then{
                $0.font = UIFont.systemFont(ofSize: 18)
                $0.textColor = .color_2C2C2C
                $0.numberOfLines = 1
                $0.text = item.data?.header?.title ?? AppConstant.EMPTY
            }
            let descView = UILabel().then{
                $0.font = UIFont.systemFont(ofSize: 16)
                $0.textColor = .color_999999
                $0.numberOfLines = 1
                $0.text = item.data?.header?.description ?? AppConstant.EMPTY
            }
            headerView.addSubview(titleView)
            headerView.addSubview(avatorView)
            headerView.addSubview(descView)
            avatorView.snp.makeConstraints{
                $0.width.equalTo(50)
                $0.height.equalTo(50)
                $0.centerY.equalToSuperview()
                $0.left.equalToSuperview().offset(10)
            }
            titleView.snp.makeConstraints{
                $0.right.equalToSuperview().inset(5)
                $0.top.equalToSuperview().offset(5)
                $0.left.equalTo(avatorView.snp.right).offset(10)
            }
            descView.snp.makeConstraints{
                $0.right.equalToSuperview().inset(5)
                $0.bottom.equalToSuperview().offset(-5)
                $0.left.equalTo(avatorView.snp.right).offset(10)
            }
            avatorView.loadRoundedImage(item.data?.header?.icon?.httpsUrlString ?? AppConstant.EMPTY,radius: 25)
    
            focusAdapter.setHeaderView(headerView, forSection: sectionStartIndex+index)
            focusAdapter.setHeaderHeight(60, forSection: sectionStartIndex+index)
        }
    }
}
