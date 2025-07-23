//
//  TopicHeaderComponent.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/7/9.
//
import UIKit
import Then
import SnapKit


class TopicHeaderComponent : UIView{
    
    //背景图片
    private lazy var coverImage = UIImageView()
    
    //顶部标题
    private lazy var titleView = UILabel().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color_000000.cgColor
        $0.numberOfLines = 1
        $0.textColor = .color_2C2C2C
        $0.clipsToBounds = true
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    
    //顶部描述文案
    private lazy var descView = UILabel().then{
        $0.textColor = .color_666666
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    
    private func initView(){
        addSubview(coverImage)
        addSubview(titleView)
        addSubview(descView)
        coverImage.snp.makeConstraints{
            $0.height.equalTo(300)
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
        }

        titleView.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(coverImage.snp.bottom)
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        descView.snp.makeConstraints{
            $0.top.equalTo(titleView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    //更新数据
    public func updateHeaderView(detail:TopicDetailModel){
        coverImage.loadImage(detail.headerImage ?? AppConstant.EMPTY)
        titleView.text = detail.brief ?? AppConstant.EMPTY
        descView.text = detail.text ?? AppConstant.EMPTY
         // 布局完成后更新高度
        layoutIfNeeded()
        let totalHeight = descView.frame.maxY
        frame.size.height = totalHeight
    }
}
