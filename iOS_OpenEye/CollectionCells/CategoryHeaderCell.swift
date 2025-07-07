//
//  CategoryHeaderCell.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/7/5.
//
import UIKit
import SnapKit
import Then

class CategoryHeaderCell : BaseTableViewCell<HomeModelIssueListItemList>{
    
    //图片
    private lazy var headerView = UIImageView()
    
    
    override func setupUI() {
        contentView.addSubview(headerView)
        headerView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(300)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func bind(_ data: HomeModelIssueListItemList, index: Int) {
        headerView.loadImage(data.headerImage?.aliImgUrlString ?? AppConstant.EMPTY)
    }
}
