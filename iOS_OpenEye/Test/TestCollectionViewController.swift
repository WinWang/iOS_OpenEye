//
//  TestCollectionViewController.swift
//  iOS_OpenEye
//  UICollectionView测试
//  Created by WinWang on 2025/5/29.
//
import Kingfisher
import SnapKit
import UIKit

class TestCollectionViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    // 定义数据源
    private let items = (1 ... 30).map { "Item \($0)" }
    // 标题栏
    private lazy var titleBar = {
        let titleBar = CommonTitleBar()
        titleBar.setTitle("CollectionView-Demo")
        return titleBar
    }()

    // 创建 UICollectionView
    private lazy var collectionView: UICollectionView = {
        // 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width / 3 - 15, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        // 初始化 CollectionView
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.delegate = self
        cv.dataSource = self
        cv.register(TestCollectionCell.classForCoder(), forCellWithReuseIdentifier: TestCollectionCell.identifier)
        return cv
    }()

    override func initView() {
        addTitleBar(titleBar)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleBar.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }

    override func initData() {}

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestCollectionCell.identifier, for: indexPath) as! TestCollectionCell
        let item = items[indexPath.item]
        cell.configure(item)
        return cell
    }
}
