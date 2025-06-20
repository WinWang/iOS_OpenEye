//
//  BaseCollectionViewAdapter.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/19.
//

import UIKit

// 基础CollectionView适配器协议
public protocol BaseCollectionViewAdapterDelegate: AnyObject {
    func onItemClick(indexPath: IndexPath, itemData: BaseItem)
    func onItemLongPress(indexPath: IndexPath, itemData: BaseItem)
}

// 基础CollectionViewCell
class BaseCollectionViewCell<T: BaseItem>: UICollectionViewCell, CellBindable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {}
    
    func bind(_ data: T, index: Int) {}
    
    func bindData(_ data: BaseItem, index: Int) {
        if let typedData = data as? T {
            bind(typedData, index: index)
        }
    }
}


// 基础CollectionView适配器
class BaseCollectionViewAdapter: NSObject {
    private(set) var collectionView: UICollectionView?
    // 数据源
    private(set) var dataList: [BaseItem] = []
    // 代理
    weak var delegate: BaseCollectionViewAdapterDelegate?
    // Header尺寸字典
    private var headerSizeDict: [Int: CGSize] = [:]
    // Footer尺寸字典
    private var footerSizeDict: [Int: CGSize] = [:]
    // Cell类型字典
    private var cellTypeDict: [Int: UICollectionViewCell.Type] = [:]
    // 单击事件
    var onItemClick: ((IndexPath, BaseItem) -> Void)?
    // 长按事件
    var onItemLongPress: ((IndexPath, BaseItem) -> Void)?
    
    //设置新数据实体
    func setNewData(_ data: [BaseItem]) {
        self.dataList = data
        self.collectionView?.reloadData()
    }
    
    //添加数据实体
    func addData(_ data: [BaseItem]) {
        self.dataList.append(contentsOf: data)
        self.collectionView?.reloadData()
    }
    
    //注册Cell
    func register<T: BaseCollectionViewCell<U>, U: BaseItem>(cellType: T.Type, forItemType itemType: Int) {
        cellTypeDict[itemType] = cellType
    }
    
    // 注册Cell到CollectionView
    func bindCollectionView(_ collectionView: UICollectionView) {
        for (_, cellType) in cellTypeDict {
            collectionView.register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
        }
        self.collectionView = collectionView
    }
    
    func setHeaderSize(_ size: CGSize, forSection section: Int) {
        headerSizeDict[section] = size
    }
    
    func setFooterSize(_ size: CGSize, forSection section: Int) {
        footerSizeDict[section] = size
    }
    
    func getItem(at indexPath: IndexPath) -> BaseItem? {
        guard indexPath.item < dataList.count else { return nil }
        return dataList[indexPath.item]
    }
}

extension BaseCollectionViewAdapter: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataList[indexPath.item]
        let itemType = item.itemType ?? 0
        
        guard let cellType = cellTypeDict[itemType] else {
            return UICollectionViewCell()
        }
        
        let identifier = String(describing: cellType)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        if let bindableCell = cell as? CellBindable {
            bindableCell.bindData(item, index: indexPath.item)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return headerSizeDict[section] ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return footerSizeDict[section] ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataList[indexPath.item]
        delegate?.onItemClick(indexPath: indexPath, itemData: item)
        onItemClick?(indexPath, item)
    }
    
    // 添加长按手势识别
    func addLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        collectionView?.addGestureRecognizer(longPress)
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let point = gesture.location(in: collectionView)
            if let indexPath = collectionView?.indexPathForItem(at: point) {
                let item = dataList[indexPath.item]
                delegate?.onItemLongPress(indexPath: indexPath, itemData: item)
                onItemLongPress?(indexPath, item)
            }
        }
    }
}





// MARK: - 使用示例
/*
// 1. 定义数据模型
class VideoItem: BaseItem {
    var title: String
    var imageUrl: String
    
    init(title: String, imageUrl: String) {
        self.title = title
        self.imageUrl = imageUrl
        super.init(itemType: 1)
    }
}

// 2. 自定义Cell
class VideoCell: BaseCollectionViewCell<VideoItem> {
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    
    override func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        
        // 设置约束...
    }
    
    override func bind(_ data: VideoItem, index: Int) {
        titleLabel.text = data.title
        // 设置图片...
    }
}

// 3. 在ViewController中使用
class ExampleViewController: UIViewController, BaseCollectionViewAdapterDelegate {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let adapter = BaseCollectionViewAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置CollectionView
        view.addSubview(collectionView)
        
        // 配置适配器
        adapter.register(cellType: VideoCell.self, forItemType: 1)
        adapter.delegate = self
        adapter.bindCollectionView(collectionView)
        
        // 添加数据
        let items = [
            VideoItem(title: "视频1", imageUrl: "url1"),
            VideoItem(title: "视频2", imageUrl: "url2")
        ]
        adapter.setNewData(items)
    }
    
    // 实现代理方法
    func onItemClick(indexPath: IndexPath, itemData: BaseItem) {
        if let videoItem = itemData as? VideoItem {
            print("点击了视频: \(videoItem.title)")
        }
    }
    
    func onItemLongPress(indexPath: IndexPath, itemData: BaseItem) {
        if let videoItem = itemData as? VideoItem {
            print("长按了视频: \(videoItem.title)")
        }
    }
}
*/
