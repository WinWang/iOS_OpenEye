//
//  TopicItemCell.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/20.
//

import UIKit

class TopicItemCell : BaseTableViewCell<TopicModelItemList> {
    
    private lazy var coverImage = UIImageView()

    override func setupUI() {
        contentView.addSubview(coverImage)
        coverImage.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(230)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func bind(_ data: TopicModelItemList, index: Int) {
        let imageUrl = data.data.image.aliImgUrlString.httpsUrlString
        coverImage.loadRoundedImage(imageUrl)
    }
    
}
