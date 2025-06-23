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
    
    //标签
    private lazy var lableView = CustomCornerLabel().then{
        $0.backgroundColor = .appPrimary
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = .white
        $0.cornerRadii.topLeft = 8
        $0.cornerRadii.bottomRight = 15
    }
    
    override func setupUI() {
        contentView.addSubview(coverImage)
        contentView.addSubview(titleView)
        contentView.addSubview(descView)
        contentView.addSubview(lableView)
        
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
        lableView.snp.makeConstraints{
            $0.left.equalTo(coverImage.snp.left)
            $0.top.equalTo(coverImage.snp.top)
            $0.width.equalTo(50)
            $0.height.equalTo(20)
        }
    }
    
    override func bind(_ data: FocusModelItemListDataItemList, index: Int) {
        titleView.text = data.data?.title ?? AppConstant.EMPTY
        descView.text = data.data?.description ?? AppConstant.EMPTY
        let imageUrl = data.data?.cover?.feed?.httpsUrlString ?? AppConstant.EMPTY
        let tag = data.data?.category ?? AppConstant.EMPTY
        coverImage.loadRoundedImage(imageUrl)
        lableView.text = tag
    }
    
}

