//
//  FocusItemCell.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/19.
//
import SnapKit
import Then
import UIKit

class FocusItemCell : BaseTableViewCell<FocusModelItemListDataItemList>{
    
    //标题View
    private lazy var titleView = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = 0
        $0.textColor = .color_2C2C2C
    }
    
    //描述View
    private lazy var descView = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = 0
        $0.textColor = .color_999999
    }
    
    //封面图
    private lazy var coverImage = UIImageView()
    
    override func setupUI() {
        contentView.addSubview(coverImage)
        contentView.addSubview(titleView)
        contentView.addSubview(descView)
        
        coverImage.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(250)
        }
        titleView.snp.makeConstraints{
            $0.top.equalTo(coverImage.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(10)
        }
        descView.snp.makeConstraints{
            $0.top.equalTo(titleView.snp.bottom).offset(6)
            $0.left.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    override func bind(_ data: FocusModelItemListDataItemList, index: Int) {
        titleView.text = data.data?.title ?? AppConstant.EMPTY
        descView.text = data.data?.description ?? AppConstant.EMPTY
        let imageUrl = data.data?.cover?.feed?.httpsUrlString ?? AppConstant.EMPTY
        coverImage.loadRoundedImage(imageUrl)
    }
    
}

