//
//  CategoryItemCell.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/19.
//

import UIKit
import SnapKit
import Then

class CategoryItemCell : BaseCollectionViewCell<CategoryModelChild>{
    
    private lazy var coverImage = UIImageView()
    
    private lazy var textTitle = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .white
    }
    
    override func setupUI() {
        contentView.addSubview(coverImage)
        contentView.addSubview(textTitle)
        coverImage.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(5)
        }
        textTitle.snp.makeConstraints{
            $0.center.equalTo(coverImage)
        }
    }
    
    override func bind(_ data: CategoryModelChild, index: Int) {
        textTitle.text = data.name
        coverImage.loadRoundedImage(data.bgPicture?.httpsUrlString.aliImgUrlString ?? AppConstant.EMPTY)
    }
}
