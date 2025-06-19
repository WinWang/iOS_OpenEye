//
//  TopicViewController.swift
//  iOS_OpenEye 专题列表
//
//  Created by WinWang on 2025/6/19.
//

import UIKit
import SnapKit
import Then
import JXSegmentedView

class TopicViewController :BaseViewController<BaseViewModel>,JXSegmentedListContainerViewListDelegate{
    
    private lazy var textLabel = UILabel().then{
        $0.text = "关注"
    }
    
    func listView() -> UIView {
        return view
    }
    
    override func initView() {
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    override func initData() {
        
    }
    
}
