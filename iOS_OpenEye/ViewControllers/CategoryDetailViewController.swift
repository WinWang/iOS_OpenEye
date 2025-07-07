//
//  CategoryDetailViewController.swift
//  iOS_OpenEye 分类详情页面
//
//  Created by WinWang on 2025/7/5.
//
import SnapKit
import Then
import UIKit

class CategoryDetailViewController: BaseViewController<CategoryDetailViewModel> {
    //分类ID
    private var id: Int
    //顶部背景图片
    private var headerImg:String
    //标题文字
    private var titleString: String
    
    init(id: Int, titleString: String,headerImg:String) {
        self.id = id
        self.headerImg = headerImg
        self.titleString = titleString
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 标题栏
    private lazy var titleBar = CommonTitleBar()
    
    // 列表适配器
    private lazy var categoryAdapter = BaseTableViewAdapter<HomeModelIssueListItemList>()
    
    // tableView
    private lazy var tableView = UITableView().then{
        $0.separatorStyle = .none
        $0.delegate = categoryAdapter
        $0.dataSource = categoryAdapter
        $0.contentInsetAdjustmentBehavior = .never
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func initView() {
        view.addSubview(stateLayout)
        stateLayout.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        stateLayout.addContentView(tableView){
            $0.edges.equalToSuperview()
        }
        categoryAdapter.register(cellType: HomeNewItemCell.self, forItemType: HomeItemType.list)
        categoryAdapter.register(cellType: CategoryHeaderCell.self, forItemType: HomeItemType.header)
        //点击事件监听
        categoryAdapter.onItemClick = { (index,item) in
            Router.shared.push(.detail(id: item.data?.id ?? 0),context: ["playUrl":item.data?.playUrl?.httpsUrlString ?? AppConstant.EMPTY])
        }
        //滚动监听
        categoryAdapter.onScroll = { [weak self] scrollView in
            let scrollY = scrollView.contentOffset.y
            if scrollY>=200 {
                self?.titleBar.setTitleBarAlpha(alpha: 1)
            }else {
                self?.titleBar.setTitleBarAlpha(alpha: scrollY/200)
            }
        }
        categoryAdapter.bindTableView(tableView)
        titleBar.setTitle(titleString)
        titleBar.setTitleBarAlpha(alpha: 0)
        addTitleBar(titleBar)
    }
    
    override func initData() {
        viewModel.getCategoryDetailList(id: id)
    }
    
    override func initObserver() {
        super.initObserver()
        subscribe(viewModel.$categoryList){ [weak self] dataList in
            var mutableDataList = dataList // ✅ 创建可变副本
            if self?.viewModel.pageIndex == 0 {
                let headerModel = HomeModelIssueListItemList(headerImage: self?.headerImg ?? AppConstant.EMPTY,itemType: HomeItemType.header)
                mutableDataList.insert(headerModel, at: 0)
            }
            self?.categoryAdapter.setNewData(mutableDataList)
        }
    }
}
