//
//  HomeViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/22.
//
import Kingfisher
import MJRefresh
import SnapKit
import Then
import UIKit


class HomeViewController: BaseViewController<HomeViewModel>{
    // 标题栏
    private lazy var titleBar = CommonTitleBar().then {
        $0.setBackButtonVisibility(false)
        $0.setTitle("首页")
    }

    // 列表
    private lazy var tableView = UITableView().then{
        $0.separatorStyle = .none
        $0.delegate = homeAdapter
        $0.dataSource = homeAdapter
    }
    
    //TableAdapter
    private lazy var homeAdapter = BaseTableViewAdapter<HomeModelIssueListItemList>()

    override func initView() {
        addTitleBar(titleBar)
        view.addSubview(stateLayout)
        stateLayout.snp.makeConstraints {
            $0.top.equalTo(titleBar.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        let contentView = UIView()
        stateLayout.addContentView(contentView) {
            $0.edges.equalToSuperview()
        }
        stateLayout.retryCallback = {[weak self] in
            self?.viewModel.getHomeList()
        }
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        initTableView()
        initRefreshLayout()
    }

    override func initData() {
        viewModel.getHomeList()
    }

    override func initObserver() {
        super.initObserver()
        subscribe(viewModel.$homeList) { [weak self] homeData in
            self?.homeAdapter.setNewData(homeData)
            self?.tableView.mj_header?.endRefreshing()
            self?.tableView.mj_footer?.endRefreshing()
        }
    }

    ///初始化TableView
    private func initTableView(){
        homeAdapter.register(cellType: HomeBannerCell.self, forItemType: HomeItemType.banner)
        homeAdapter.register(cellType: HomeNewItemCell.self, forItemType: HomeItemType.list)
         // 统一的点击事件处理
         homeAdapter.onItemClick = { _, item in
             switch item.itemType {
             case HomeItemType.banner:
                 logDebug("点击了Banner->")
                 break
             case HomeItemType.list:
                 logDebug("点击了HomeItem->")
                 break
             default:
                 break
             }
         }
        homeAdapter.bindTableView(tableView)
    }
    
    /// 初始化下拉刷新
    private func initRefreshLayout() {
        tableView.mj_header = MJRefreshNormalHeader { [weak self] in
            self?.viewModel.date = AppConstant.EMPTY
            self?.viewModel.getHomeList()
        }
        tableView.mj_footer = MJRefreshAutoNormalFooter { [weak self] in
            self?.viewModel.getHomeList()
        }
    }
}


//原生方式实现
//class HomeViewController: BaseViewController<HomeViewModel>, UITableViewDelegate, UITableViewDataSource {
//    // 标题栏
//    private lazy var titleBar = CommonTitleBar().then {
//        $0.setBackButtonVisibility(false)
//        $0.setTitle("首页")
//    }
//
//    // 列表
//    private lazy var tableView = UITableView().then {
//        $0.delegate = self
//        $0.dataSource = self
//        $0.register(HomeItemCell.self, forCellReuseIdentifier: "CustomTableViewCell")
//        $0.separatorStyle = .singleLine
//        $0.tableFooterView = UIView()
//    }
//
//    override func initView() {
//        addTitleBar(titleBar)
//        view.addSubview(stateLayout)
//        stateLayout.snp.makeConstraints {
//            $0.top.equalTo(titleBar.snp.bottom)
//            $0.width.equalToSuperview()
//            $0.bottom.equalToSuperview()
//        }
//        let contentView = UIView()
//        stateLayout.addContentView(contentView) {
//            $0.edges.equalToSuperview()
//        }
//        contentView.addSubview(tableView)
//        tableView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        initRefreshLayout()
//    }
//
//    override func initData() {
//        viewModel.getHomeList()
//    }
//
//    override func initObserver() {
//        super.initObserver()
//        subscribe(viewModel.$homeList) { [weak self] _ in
//            self?.tableView.reloadData()
//            self?.tableView.mj_header?.endRefreshing()
//            self?.tableView.mj_footer?.endRefreshing()
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.homeList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // 1. 取出单元格并强制转换为自定义类型
//        guard let cell = tableView.dequeueReusableCell(
//            withIdentifier: "CustomTableViewCell",
//            for: indexPath
//        ) as? HomeItemCell else {
//            // 错误处理：返回默认单元格
//            return UITableViewCell(style: .default, reuseIdentifier: "defaultCell")
//        }
//        // 设置数据
//        guard indexPath.row < viewModel.homeList.count else {
//            cell.bindItemData(nil)
//            return cell
//        }
//
//        let item = viewModel.homeList[indexPath.row]
//        cell.bindItemData(item.data) // 在Cell内部安全处理data为nil的情况
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        Router.shared.push(RoutePath.detail(id: String(describing: viewModel.homeList[indexPath.row].data?.id)))
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 400 // 估算高度，提高性能
//    }
//
//    /// 初始化下拉刷新
//    private func initRefreshLayout() {
//        tableView.mj_header = MJRefreshNormalHeader { [weak self] in
//            self?.viewModel.date = AppConstant.EMPTY
//            self?.viewModel.getHomeList()
//        }
//        tableView.mj_footer = MJRefreshAutoNormalFooter { [weak self] in
//            self?.viewModel.getHomeList()
//        }
//    }
//}
