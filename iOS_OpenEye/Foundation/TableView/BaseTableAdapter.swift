//
//  BaseTableAdapter.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/18.
//

import UIKit

// 基础TableViewCell
class BaseTableViewCell<T: BaseItem>: UITableViewCell, CellBindable {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {}
    
    func bind(_ data: T , index :Int){}
    
    func bindData(_ data: BaseItem ,index:Int) {
        if let typedData = data as? T {
            bind(typedData,index:index)
        }
    }
}

// 基础TableView适配器
class BaseTableViewAdapter<T:BaseItem>: NSObject,UITableViewDataSource, UITableViewDelegate {
    private(set) var tableView:UITableView?
    // 数据源
    private(set) var dataList: [T] = []
    // 代理
    weak var delegate: BaseTableViewAdapterDelegate?
    // Header高度字典
    private var headerHeightDict: [Int: CGFloat] = [:]
    // Footer高度字典
    private var footerHeightDict: [Int: CGFloat] = [:]
    // Cell类型字典
    private var cellTypeDict: [Int: UITableViewCell.Type] = [:]
    // 单击事件
    var onItemClick: ((IndexPath, T) -> Void)?
    // 长按事件
    var onItemLongPress: ((IndexPath, T) -> Void)?
    
    //设置新数据实体
    func setNewData(_ data: [T]) {
        self.dataList = data
        self.tableView?.reloadData()
    }
    
    //添加数据实体
    func addData(_ data: [T]) {
        self.dataList.append(contentsOf: data)
        self.tableView?.reloadData()
    }
    
    //注册Cell
    func register<Cell: BaseTableViewCell<U>, U: BaseItem>(cellType: Cell.Type, forItemType itemType: Int) {
        cellTypeDict[itemType] = cellType
    }
    
    // 注册Cell到TableView
    func bindTableView(_ tableView: UITableView) {
        for (_, cellType) in cellTypeDict {
            tableView.register(cellType, forCellReuseIdentifier: String(describing: cellType))
        }
        self.tableView = tableView
    }
    
    func setHeaderHeight(_ height: CGFloat, forSection section: Int) {
        headerHeightDict[section] = height
    }
    
    func setFooterHeight(_ height: CGFloat, forSection section: Int) {
        footerHeightDict[section] = height
    }
    
    func getItem(at indexPath: IndexPath) -> T? {
        guard indexPath.row < dataList.count else { return nil }
        return dataList[indexPath.row]
    }

    
    /**********************************************************************DataSource和Delegate实现类**START***************************************************************************************************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataList[indexPath.row]
        let itemType = item.itemType
        
        guard let cellType = cellTypeDict[itemType] else {
            return UITableViewCell()
        }
        
        let identifier = String(describing: cellType)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if let bindableCell = cell as? CellBindable {
            bindableCell.bindData(item,index: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeightDict[section] ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeightDict[section] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataList[indexPath.row]
        delegate?.onItemClick(indexPath: indexPath, itemData: item)
        onItemClick?(indexPath, item)
    }
    
    func tableView(_ tableView: UITableView, didLongPressRowAt indexPath: IndexPath) {
        let item = dataList[indexPath.row]
        delegate?.onItemLongPress(indexPath: indexPath, itemData: item)
        onItemLongPress?(indexPath, item)
    }
    /**********************************************************************DataSource和Delegate实现类***END**************************************************************************************************************/
    
}

//extension BaseTableViewAdapter : UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataList.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = dataList[indexPath.row]
//        let itemType = item.itemType
//        
//        guard let cellType = cellTypeDict[itemType] else {
//            return UITableViewCell()
//        }
//        
//        let identifier = String(describing: cellType)
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//        
//        if let bindableCell = cell as? CellBindable {
//            bindableCell.bindData(item,index: indexPath.row)
//        }
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return headerHeightDict[section] ?? 0
//    }
//    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return footerHeightDict[section] ?? 0
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = dataList[indexPath.row]
//        delegate?.onItemClick(indexPath: indexPath, itemData: item)
//        onItemClick?(indexPath, item)
//    }
//    
//    func tableView(_ tableView: UITableView, didLongPressRowAt indexPath: IndexPath) {
//        let item = dataList[indexPath.row]
//        delegate?.onItemLongPress(indexPath: indexPath, itemData: item)
//        onItemLongPress?(indexPath, item)
//    }
//}

// 定义ItemType常量
//enum ItemType {
//    static let banner = 0
//    static let list = 1
//}

// Banner数据模型
//struct BannerItem: BaseItem {
//    let imageUrl: String
//    let title: String
//    let itemType: Int = ItemType.banner
//}
//
//// 普通列表项数据模型
//struct ListItem: BaseItem {
//    let title: String
//    let subtitle: String
//    let itemType: Int = ItemType.list
//}
//
//// Banner Cell
//class BannerCell: BaseTableViewCell<BannerItem> {
//    private let titleLabel = UILabel()
//    private let bannerImageView = UIImageView()
//
//    override func setupUI() {
//        // 设置UI布局
//    }
//
//    override func bind(_ data: BannerItem) {
//        titleLabel.text = data.title
//        // 设置图片
//    }
//}
//
//// 普通列表项 Cell
//class ListItemCell: BaseTableViewCell<ListItem> {
//    private let titleLabel = UILabel()
//    private let subtitleLabel = UILabel()
//
//    override func setupUI() {
//        // 设置UI布局
//    }
//
//    override func bind(_ data: ListItem) {
//        titleLabel.text = data.title
//        subtitleLabel.text = data.subtitle
//    }
//}
//
//// 示例用法
//class ExampleViewController: UIViewController {
//    private lazy var tableView: UITableView = {
//        let table = UITableView()
//        table.delegate = adapter
//        table.dataSource = adapter
//        return table
//    }()
//
//    private lazy var adapter: BaseTableViewAdapter = {
//        let adapter = BaseTableViewAdapter()
//        adapter.delegate = self
//        return adapter
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTableView()
//    }
//
//    private func setupTableView() {
//        adapter.register(cellType: BannerCell.self, forItemType: ItemType.banner)
//        adapter.register(cellType: ListItemCell.self, forItemType: ItemType.list)
//
//        adapter.setHeaderHeight(50, forSection: 0)
//
//        let mixedData: [BaseItem] = [
//            BannerItem(imageUrl: "banner1.jpg", title: "Banner 1"),
//            ListItem(title: "标题1", subtitle: "副标题1"),
//            ListItem(title: "标题2", subtitle: "副标题2"),
//            BannerItem(imageUrl: "banner2.jpg", title: "Banner 2"),
//            ListItem(title: "标题3", subtitle: "副标题3")
//        ]
//
//        adapter.setNewData(mixedData)
//
//        // 统一的点击事件处理
//        adapter.onItemClick = { _, item in
//            switch item.itemType {
//            case ItemType.banner:
//                if let bannerItem = item as? BannerItem {
//                    print("点击了Banner: \(bannerItem.title)")
//                }
//            case ItemType.list:
//                if let listItem = item as? ListItem {
//                    print("点击了列表项: \(listItem.title)")
//                }
//            default:
//                break
//            }
//        }
//    }
//}
//
//extension ExampleViewController: BaseTableViewAdapterDelegate {
//    func onItemClick(indexPath: IndexPath, itemData: BaseItem) {
//        // 处理点击事件
//    }
//
//    func onItemLongPress(indexPath: IndexPath, itemData: BaseItem) {
//        // 处理长按事件
//    }
//}
