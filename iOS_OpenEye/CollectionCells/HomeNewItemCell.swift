//
//  HomeNewItemCell.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/18.
//

import SnapKit
import Then
import UIKit

class HomeNewItemCell : BaseTableViewCell<HomeModelIssueListItemList>{
    
    // 封面图片
    private lazy var coverImage = UIImageView()
    
    // cardView
    private lazy var cardView = UIView().then {
        $0.backgroundColor = .white
    }

    // 头像图片
    private lazy var avator = UIImageView()
    
    // 标题
    private lazy var titleView = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .color_2C2C2C
        $0.numberOfLines = 1
    }
    
    // 描述
    private lazy var descView = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .color_999999
        $0.numberOfLines = 1
    }
    
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
        cardView.addSubview(coverImage)
        cardView.addSubview(avator)
        cardView.addSubview(titleView)
        cardView.addSubview(descView)
        cardView.addSubview(lableView)
        contentView.addSubview(cardView)
    
        cardView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(5)
            $0.height.equalTo(330)
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10) // 添加底部约束，确保contentView被撑开
        }
        
        cardView.cardView(
            cornerRadius: 8,
            shadowOpacity: 0.2,
            shadowOffset: CGSize(width: 0, height: 3),
            shadowRadius: 8
        )
        
        coverImage.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(250)
            $0.top.equalToSuperview()
        }
        
        avator.snp.makeConstraints {
            $0.top.equalTo(coverImage.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(5)
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(coverImage.snp.bottom).offset(20)
            $0.left.equalTo(avator.snp.right).offset(5)
        }
        
        descView.snp.makeConstraints {
            $0.bottom.equalTo(avator.snp.bottom).offset(-5)
            $0.left.equalTo(avator.snp.right).offset(5)
            $0.right.equalToSuperview().inset(10)
        }
        
        lableView.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(20)
        }
    }
    
    override func bind(_ item: HomeModelIssueListItemList?,index:Int) {
        let imageUrl = item?.data?.cover?.feed?.httpsUrlString ?? AppConstant.EMPTY
        let avatorUrl = item?.data?.author?.icon?.httpsUrlString ?? AppConstant.EMPTY
        let desc = item?.data?.author?.description ?? AppConstant.EMPTY
        let title = item?.data?.author?.name ?? AppConstant.EMPTY
        let tag = item?.data?.category ?? AppConstant.EMPTY
        coverImage.loadRoundedImage(imageUrl)
        avator.loadRoundedImage(avatorUrl, radius: 25)
        titleView.text = title
        descView.text = desc
        lableView.text = tag
    }
}
