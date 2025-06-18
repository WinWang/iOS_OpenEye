//
//  HomeItemCell.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/15.
//

import SnapKit
import Then
import UIKit

class HomeItemCell: UITableViewCell {
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
    
    // 唯一标识符
    static let identifier = "CustomTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        cardView.addSubview(coverImage)
        cardView.addSubview(avator)
        cardView.addSubview(titleView)
        cardView.addSubview(descView)
        contentView.addSubview(cardView)
    
        cardView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(5)
            $0.height.equalTo(330)
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10) // 添加底部约束，确保contentView被撑开
        }
        
        cardView.cardView(
            cornerRadius: 8,
            shadowColor: .appPrimary,
            shadowOpacity: 0.5,
            shadowOffset: CGSize(width: 5, height: 5),
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
    }
    
    func bindItemData(_ item: HomeModelIssueListItemListData?) {
        let imageUrl = item?.cover?.feed?.httpsUrlString ?? AppConstant.EMPTY
        let avatorUrl = item?.author?.icon.httpsUrlString ?? AppConstant.EMPTY
        let title = item?.author?.name ?? AppConstant.EMPTY
        let desc = item?.author?.description ?? AppConstant.EMPTY
        coverImage.loadRoundedImage(imageUrl)
        avator.loadRoundedImage(avatorUrl, radius: 25)
        titleView.text = title
        descView.text = desc
    }
    
    // 重置单元格状态
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImage.image = nil
    }
}
