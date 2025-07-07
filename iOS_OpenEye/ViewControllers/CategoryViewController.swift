//
//  CategoryViewController.swift
//  iOS_OpenEye 分类列表
//
//  Created by WinWang on 2025/6/19.
//

import UIKit
import SnapKit
import Then
import JXSegmentedView
import MJRefresh

class CategoryViewController : BaseViewController<CategoryViewModel>,JXSegmentedListContainerViewListDelegate{
    
    //layoutManager
    private lazy var flowLayoutManager = UICollectionViewFlowLayout().then{
        let width = view.bounds.width / 2 - 2
        $0.scrollDirection = .vertical
        $0.itemSize = CGSize(width: width, height: width)
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
        $0.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    
    //colletionView
    private lazy var collectionView = UICollectionView(frame: .zero,collectionViewLayout: flowLayoutManager).then{
        $0.delegate = categoryAdapter
        $0.dataSource = categoryAdapter
    }
    
    //适配器Adapter
    private lazy var categoryAdapter = BaseCollectionViewAdapter()
    
    func listView() -> UIView {
        return view
    }
    
    override func initView() {
        view.addSubview(stateLayout)
        stateLayout.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stateLayout.addContentView(collectionView){
            $0.edges.equalToSuperview()
        }
        //绑定Adapter
        categoryAdapter.register(cellType: CategoryItemCell.self, forItemType: 0)
        categoryAdapter.bindCollectionView(collectionView)
        categoryAdapter.onItemClick = {_, item in
            let itemData =  item as! CategoryModelChild
            let param =  [
                "title":itemData.name ?? AppConstant.EMPTY,
                "backUrl":itemData.headerImage?.httpsUrlString ?? AppConstant.EMPTY,
                "id":itemData.id ?? 0
            ]
            Router.shared.push(RoutePath.categoryDetail,context: param)
        }
        //下拉刷新
        collectionView.mj_header = MJRefreshNormalHeader(){[weak self] in
            self?.viewModel.getCategoryList()
        }
    }
    
    override func initData() {
        viewModel.getCategoryList()
    }
    
    override func initObserver() {
        super.initObserver()
        subscribe(viewModel.$categogyList){[weak self] data in
            self?.categoryAdapter.setNewData(data)
            self?.collectionView.mj_header?.endRefreshing()
        }
    }
}
