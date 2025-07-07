//
//  VideoListCell.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/7/4.
//

import UIKit
import Then
import SnapKit


class VideoListCell : BaseTableViewCell<HomeModelIssueListItemList>{
    
    //封面
    private lazy var coverImage = UIImageView()
    
    //标题
    private lazy var titleView = UILabel().then{
        $0.numberOfLines = 1
        $0.textColor = .color_2C2C2C
        $0.font = UIFont.systemFont(ofSize: 17)
    }

    //描述
    private lazy var descView = UILabel().then{
        $0.numberOfLines = 2
        $0.textColor = .color_999999
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    override func setupUI() {
        contentView.addSubview(coverImage)
        contentView.addSubview(titleView)
        contentView.addSubview(descView)
        coverImage.snp.makeConstraints{
            $0.left.equalToSuperview().offset(10)
            $0.height.equalTo(95)
            $0.width.equalTo(150)
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10) // 添加底部约束，确保contentView被撑开
        }
        titleView.snp.makeConstraints{
            $0.top.equalTo(coverImage.snp.top)
            $0.left.equalTo(coverImage.snp.right).offset(10)
            $0.right.equalToSuperview().inset(10)
        }
        descView.snp.makeConstraints{
            $0.top.equalTo(titleView.snp.bottom).offset(15)
            $0.right.equalToSuperview().inset(10)
            $0.left.equalTo(coverImage.snp.right).offset(10)
        }
    }
    
    
    override func bind(_ data: HomeModelIssueListItemList, index: Int) {
        titleView.text = data.data?.title ?? AppConstant.EMPTY
        descView.text = data.data?.description ?? AppConstant.EMPTY
        coverImage.loadRoundedImage(data.data?.cover?.feed?.httpsUrlString ?? AppConstant.EMPTY)
    }
    
}
