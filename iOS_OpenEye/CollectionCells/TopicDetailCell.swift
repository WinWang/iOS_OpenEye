//
//  TopicDetailCell.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/7/9.
//
import BMPlayer
import SnapKit
import Then
import UIKit

class TopicDetailCell: BaseTableViewCell<TopicDetailModelItemList> {
    private var index: Int = 0
    
    private lazy var customControllerView = CustomeListPlayerControllerView()
    
    // 播放器实例
    private lazy var player = BMPlayer(customControlView: customControllerView).then{
        $0.autoPlay()
    }
    
    // 封面图片
//    private lazy var coverImage = UIImageView()
    
    // cardView
    private lazy var cardView = UIView().then {
        $0.backgroundColor = .white
    }
    
    // 顶部标题
    private lazy var titleView = UILabel().then {
        $0.numberOfLines = 1
        $0.textColor = .color_2C2C2C
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    
    // 顶部描述文案
    private lazy var descView = UILabel().then {
        $0.textColor = .color_666666
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    override func setupUI() {
        contentView.addSubview(cardView)
        cardView.addSubview(player)
        cardView.addSubview(descView)
        cardView.addSubview(titleView)
//        cardView.addSubview(coverImage)
        
        cardView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(5)
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10) // 添加底部约束，确保contentView被撑开
        }
        
        cardView.cardView(
            cornerRadius: 8,
            shadowOpacity: 0.2,
            shadowOffset: CGSize(width: 0, height: 3),
            shadowRadius: 8
        )
        
//        coverImage.snp.makeConstraints{
//            $0.height.equalTo(220)
//            $0.top.equalToSuperview().offset(10)
//            $0.leading.trailing.equalToSuperview().inset(6)
//        }
        
        player.snp.makeConstraints {
            $0.height.equalTo(220)
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(6)
        }

        titleView.snp.makeConstraints {
            $0.top.equalTo(player.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        descView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    override func bind(_ data: TopicDetailModelItemList, index: Int) {
        self.index = index
        titleView.text = data.data?.content?.data?.title ?? AppConstant.EMPTY
        descView.text = data.data?.content?.data?.description ?? AppConstant.EMPTY
//        coverImage.loadImage(data.data?.content?.data?.cover?.feed ?? AppConstant.EMPTY)
        let asset = BMPlayerResource(
            url: URL(string: data.data?.content?.data?.playUrl ?? AppConstant.EMPTY)!,
            name: AppConstant.EMPTY,
            cover: URL(string: data.data?.content?.data?.cover?.feed ?? AppConstant.EMPTY)
        )
        player.setVideo(resource: asset)
        player.pause()
    }
    
    public func playVideo() {
        logDebug("当前居中的UI\(index)")
    }
    
    override func prepareForReuse() {
        logDebug("初始化的角标\(index)")
    }
    
    deinit {
        logDebug("销毁的角标\(index)")
    }
}
