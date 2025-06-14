//
//  TextRefreshViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/29.
//
import MJRefresh
import UIKit

class TestRefreshViewController: BaseViewController<BaseViewModel>, UITableViewDelegate, UITableViewDataSource {
    // 数据源
    private var dataSource = [String]()
    private var currentPage = 1
    private let pageSize = 20
    
    // 标题栏
    private lazy var titleBar = {
        let titleBar = CommonTitleBar()
        titleBar.setTitle("MJRefresh")
        return titleBar
    }()

    // 表格视图
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func initView() {
        addTitleBar(titleBar)
        setupTableView()
        setupRefreshControl()
        loadInitialData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupRefreshControl() {
        // 设置下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.refreshData()
        })
        
        // 设置上拉加载
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self?.loadMoreData()
        })
    }
    
    private func loadInitialData() {
        tableView.mj_header?.beginRefreshing()
    
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            self.dataSource = (1...self.pageSize).map { "Item \($0)" }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
    private func refreshData() {
        currentPage = 1
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.dataSource = (1...self.pageSize).map { "Item \($0) (刷新后)" }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.resetNoMoreData()
            }
        }
    }
        
    private func loadMoreData() {
        currentPage += 1
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let totalItems = self.currentPage * self.pageSize
            let newData = (totalItems - self.pageSize + 1...totalItems).map { "Item \($0)" }
                
            DispatchQueue.main.async {
                self.dataSource.append(contentsOf: newData)
                self.tableView.reloadData()
                    
                // 模拟没有更多数据
                if self.currentPage >= 5 {
                    self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                } else {
                    self.tableView.mj_footer?.endRefreshing()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("选中: \(dataSource[indexPath.row])")
    }
}
