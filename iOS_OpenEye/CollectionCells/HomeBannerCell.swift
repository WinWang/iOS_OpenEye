//
//  HomeBannerCell.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/18.
//
import UIKit
import Then
import SnapKit
import FSPagerView

class HomeBannerCell :BaseTableViewCell<HomeModelIssueListItemList>, FSPagerViewDataSource,FSPagerViewDelegate {

    // 图片链接数组
    private let imageUrls:[String] = [
        "https://ali-img.kaiyanapp.com/a8f6e2a785b4812ccf946a40c0f60475.png?imageMogr2/quality/60/format/jpg",
        "https://ali-img.kaiyanapp.com/7a73b2b8561170cbf83a52fb936a0e49.jpeg?imageMogr2/quality/60/format/jpg",
        "https://ali-img.kaiyanapp.com/fe76fa31683663c7e3c22b41a03145a6.jpeg?imageMogr2/quality/60/format/jpg"
    ]
    
    //轮播图控件
    private lazy var bannerView = FSPagerView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        // 自动滚动时间间隔
        $0.automaticSlidingInterval = 3.0
        // 是否无限循环
        $0.isInfinite = true
        // 交互方式
        $0.interitemSpacing = 0
        // 注册cell
        $0.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        //数据源代理
        $0.dataSource = self
        //交互代理
        $0.delegate = self
    }
    //轮播指示器
    private lazy var pageController = FSPageControl().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        // 设置页面指示器样式
        $0.setFillColor(.appPrimary, for: .selected)
        $0.setFillColor(.gray, for: .normal)
    }
    
    override func setupUI() {
        contentView.addSubview(bannerView)
        contentView.addSubview(pageController)
        bannerView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(250)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        pageController.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    override func bind(_ item: HomeModelIssueListItemList?,index:Int) {
        pageController.numberOfPages = imageUrls.count
        bannerView.reloadData()
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        imageUrls.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
         let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
         let imageUrl = imageUrls[index]
         cell.imageView?.loadImage(imageUrl)
         return cell
    }
    
    // MARK: - FSPagerViewDelegate
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageController.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        pageController.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        // 处理Banner点击事件
        let banner = imageUrls[index]
        // TODO: 处理跳转逻辑
    }
}
