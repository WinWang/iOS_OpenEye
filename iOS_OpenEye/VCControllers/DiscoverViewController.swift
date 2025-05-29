import IGListKit
import UIKit

//
//  DiscoverViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/23.
//

class DiscoverViewController: BaseViewController {
    @IBOutlet var collectionView: UICollectionView!

    // 标题栏
    private lazy var titleBar = {
        let titleBar = CommonTitleBar()
        titleBar.setBackButtonVisibility(false)
        titleBar.setTitle("发现")
        return titleBar
    }()

    override func initView() {
        addTitleBar(titleBar)
    }

    override func initData() {}
}
