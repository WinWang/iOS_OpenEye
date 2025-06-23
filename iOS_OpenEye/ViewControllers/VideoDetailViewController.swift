//
//  DetailViewContraller.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/26.
//

import Foundation
import UIKit
import SnapKit
import Then

class VideoDetailViewController: BaseViewController<BaseViewModel> {
    
    private let id: Int

    private lazy var titleBar =  CommonTitleBar().then{
        $0.setTitle("视频详情")
    }

    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func initView() {
        addTitleBar(titleBar)
    }

    override func initData() {
        
    }
    
    override func initObserver() {
        super.initObserver()
    }
}
