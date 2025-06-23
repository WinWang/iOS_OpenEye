//
//  SettingView.swift
//  iOS_OpenEye SettingView
//
//  Created by WinWang on 2025/6/22.
//

import UIKit
import Then
import SnapKit

class SettingView : UIView{

    var clickAction :NoParamUnitAction?
    
    //容器约束View
    private lazy var contentView  = UIView().then{
        $0.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        $0.addGestureRecognizer(tapGesture)
    }
    
    //图片
    private lazy var imageView = UIImageView()
    
    //文字
    private lazy var textView = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .color_2C2C2C
    }
    //分割线
    private lazy var divider = UIView().then{
        $0.backgroundColor = .color_F8F8F8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    //初始化View
    private func initView(){
        isUserInteractionEnabled = true
        addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(textView)
        contentView.addSubview(divider)
        
        contentView.snp.makeConstraints{
            $0.height.equalTo(50)
            $0.width.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.width.equalTo(30)
            $0.height.equalTo(30)
            $0.left.equalToSuperview().offset(15)
        }
        
        textView.snp.makeConstraints{
            $0.left.equalTo(imageView.snp.right).offset(10)
            $0.centerY.equalToSuperview()
        }
        
        divider.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    //设置图片icon
    public func setImageIcon(_ imageName:String){
        let image = UIImage(named: imageName)
        imageView.image = image
    }
    
    //设置标题
    public func setTitle(_ title:String){
        textView.text = title
    }

    //点击
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        clickAction?()
    }
}
