//
//  HomeBannerCell.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/18.
//
import UIKit
import Then
import SnapKit

class HomeBannerCell :BaseTableViewCell<HomeModelIssueListItemList>{
    
    // 封面图片
    private lazy var coverImage = UIImageView()
    
    override func setupUI() {
        contentView.addSubview(coverImage)
        coverImage.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(250)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func bind(_ item: HomeModelIssueListItemList?) {
        let imageUrl = item?.data?.cover?.feed?.httpsUrlString ?? AppConstant.EMPTY
        coverImage.loadRoundedImage(imageUrl)
    }
    
}
