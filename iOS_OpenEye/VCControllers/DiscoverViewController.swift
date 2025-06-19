//
//  DiscoverViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/23.
//
import UIKit
import Then
import JXSegmentedView

class DiscoverViewController: BaseViewController<DiscoverViewModel>,JXSegmentedListContainerViewDataSource {
    
    // 标题栏
    private lazy var titleBar = CommonTitleBar().then{
       $0.setBackButtonVisibility(false)
       $0.setTitle("发现")
    }
    //TabLayout
    private lazy var segmentedView = JXSegmentedView().then{
        $0.backgroundColor = .appPrimary
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //底部容器-类似Android Viewpager
    private lazy var contentView = JXSegmentedListContainerView(dataSource: self)
    
    // 标题数据源
    private lazy var dataSource: JXSegmentedTitleDataSource = {
        let source = JXSegmentedTitleDataSource()
        source.titles = viewModel.tabTitles
        source.titleNormalColor = .color_F6F6F6
        source.titleSelectedColor = .color_FFFFFF
        source.isItemSpacingAverageEnabled = true
        source.titleNormalFont = .systemFont(ofSize: 15)
        source.titleSelectedFont = .boldSystemFont(ofSize: 17)
        source.isTitleColorGradientEnabled = true
        return source
     }()
    
    // 指示器
    private lazy var indicator: JXSegmentedIndicatorLineView = {
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.indicatorHeight = 3
        indicator.indicatorWidth = 50
        indicator.indicatorColor = .white
        indicator.indicatorPosition = .bottom
        return indicator
    }()

    override func initView() {
        addTitleBar(titleBar)
        view.addSubview(segmentedView)
        view.addSubview(contentView)
        segmentedView.snp.makeConstraints{
            $0.height.equalTo(60)
            $0.width.equalToSuperview()
            $0.top.equalTo(titleBar.snp.bottom)
        }
        contentView.snp.makeConstraints{
            $0.top.equalTo(segmentedView.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    override func initData() {
        // 绑定数据
        segmentedView.dataSource = dataSource
        // 设置指示器
        segmentedView.indicators = [indicator]
        // 关联contentView
        segmentedView.listContainer = contentView
    }
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
       return viewModel.tabTitles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        switch index {
        case 0:
            return FocusViewController()
        case 1:
            return CategoryViewController()
        case 2:
            return TopicViewController()
        default:
            return FocusViewController()
        }
    }
    
}
