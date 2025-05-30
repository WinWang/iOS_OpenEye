//
//  HomeCollectionCell.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/29.
//
import UIKit
class TestCollectionCell :UICollectionViewCell{
    static let identifier = "HomeCollectionViewCell"
    //文本UI
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("异常")
    }
    
    private func setupViews(){
        backgroundColor = .appPrimary
        layer.cornerRadius = 10
        clipsToBounds = true
        
        //添加标签
        contentView.addSubview(label)
        label.frame = contentView.bounds
    }
    
    func configure(_ text:String){
        label.text = text
    }
    

}
