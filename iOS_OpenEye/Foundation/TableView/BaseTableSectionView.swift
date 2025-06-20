//
//  BaseTableAdapter.swift
//  iOS_OpenEye。  Section Header从外部添加的实现
//
//  Created by WinWang on 2025/6/18.
//

import UIKit

// 基础TableView适配器
class BaseTableSectionViewAdapter<T:BaseItem>: NSObject,UITableViewDataSource, UITableViewDelegate {
    private(set) var tableView:UITableView?
    // 数据源(二维数组用于section)
    private(set) var dataList: [[T]] = []
    // 代理
    weak var delegate: BaseTableViewAdapterDelegate?
    // Header高度字典
    private var headerHeightDict: [Int: CGFloat] = [:]
    // Footer高度字典
    private var footerHeightDict: [Int: CGFloat] = [:]
    // Cell类型字典
    private var cellTypeDict: [Int: UITableViewCell.Type] = [:]
    // Header视图字典
    private var headerViewDict: [Int: UIView] = [:]
    // 单击事件
    var onItemClick: ((IndexPath, T) -> Void)?
    // 长按事件
    var onItemLongPress: ((IndexPath, T) -> Void)?
    
    //设置新数据实体
    func setNewData(_ data: [[T]]) {
        self.dataList = data
        self.tableView?.reloadData()
    }
    
    //添加数据实体到指定section
    func addData(_ data: [T], toSection section: Int) {
        if section < dataList.count {
            dataList[section].append(contentsOf: data)
            self.tableView?.reloadSections(IndexSet(integer: section), with: .automatic)
        }
    }
    
    //添加数据实体到指定section
    func addData(_ data: [[T]]) {
        self.dataList.append(contentsOf: data)
        let indexSet = IndexSet(integersIn: dataList.count - data.count..<dataList.count)
        self.tableView?.insertSections(indexSet, with: .automatic)
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
    
    // 设置section header高度
    func setHeaderHeight(_ height: CGFloat, forSection section: Int) {
        headerHeightDict[section] = height
    }
    
    // 设置section footer高度
    func setFooterHeight(_ height: CGFloat, forSection section: Int) {
        footerHeightDict[section] = height
    }
    
    // 设置section header视图
    func setHeaderView(_ view: UIView, forSection section: Int) {
        headerViewDict[section] = view
    }
    
    // 移除fHeaderView
    func removerHeaderView(){
        headerViewDict.removeAll()
    }
    
    func getItem(at indexPath: IndexPath) -> T? {
        guard indexPath.section < dataList.count,
              indexPath.row < dataList[indexPath.section].count else { return nil }
        return dataList[indexPath.section][indexPath.row]
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataList[indexPath.section][indexPath.row]
        let itemType = item.itemType ?? 0
        
        guard let cellType = cellTypeDict[itemType] else {
            return UITableViewCell()
        }
        
        let identifier = String(describing: cellType)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if let bindableCell = cell as? CellBindable {
            bindableCell.bindData(item, index: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerViewDict[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeightDict[section] ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeightDict[section] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataList[indexPath.section][indexPath.row]
        delegate?.onItemClick(indexPath: indexPath, itemData: item)
        onItemClick?(indexPath, item)
    }
    
    func tableView(_ tableView: UITableView, didLongPressRowAt indexPath: IndexPath) {
        let item = dataList[indexPath.section][indexPath.row]
        delegate?.onItemLongPress(indexPath: indexPath, itemData: item)
        onItemLongPress?(indexPath, item)
    }
}

//// 示例用法
//class ExampleViewController: UIViewController {
//    private lazy var tableView: UITableView = {
//        let table = UITableView(frame: .zero, style: .grouped)
//        table.delegate = adapter
//        table.dataSource = adapter
//        return table
//    }()
//    
//    private lazy var adapter: BaseTableViewAdapter<BaseItem> = {
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
//        view.addSubview(tableView)
//        tableView.frame = view.bounds
//        
//        // 注册Cell类型
//        adapter.register(cellType: BannerCell.self, forItemType: ItemType.banner)
//        adapter.register(cellType: ListItemCell.self, forItemType: ItemType.list)
//        
//        // 绑定TableView
//        adapter.bindTableView(tableView)
//        
//        // 设置Section Header
//        for section in 0...1 {
//            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
//            headerView.backgroundColor = .lightGray
//            let label = UILabel(frame: CGRect(x: 15, y: 0, width: 200, height: 50))
//            label.text = "Section \(section) Header"
//            headerView.addSubview(label)
//            
//            adapter.setHeaderView(headerView, forSection: section)
//            adapter.setHeaderHeight(50, forSection: section)
//        }
//        
//        // 准备分section的数据
//        let section0Data: [BaseItem] = [
//            BannerItem(imageUrl: "banner1.jpg", title: "Banner 1"),
//            BannerItem(imageUrl: "banner2.jpg", title: "Banner 2")
//        ]
//        
//        let section1Data: [BaseItem] = [
//            ListItem(title: "列表项1", subtitle: "描述1"),
//            ListItem(title: "列表项2", subtitle: "描述2"),
//            ListItem(title: "列表项3", subtitle: "描述3")
//        ]
//        
//        // 设置数据
//        adapter.setNewData([section0Data, section1Data])
//        
//        // 点击事件处理
//        adapter.onItemClick = { indexPath, item in
//            print("点击了Section \(indexPath.section) 的第 \(indexPath.row) 项")
//        }
//    }
//}
//
//// 示例Cell和数据模型
//enum ItemType {
//    static let banner = 0
//    static let list = 1
//}
//
//struct BannerItem: BaseItem {
//    let imageUrl: String
//    let title: String
//    let itemType: Int = ItemType.banner
//}
//
//struct ListItem: BaseItem {
//    let title: String
//    let subtitle: String
//    let itemType: Int = ItemType.list
//}
//
//class BannerCell: BaseTableViewCell<BannerItem> {
//    private let titleLabel = UILabel()
//    
//    override func setupUI() {
//        contentView.addSubview(titleLabel)
//        titleLabel.frame = CGRect(x: 15, y: 10, width: 200, height: 30)
//    }
//    
//    override func bind(_ data: BannerItem, index: Int) {
//        titleLabel.text = data.title
//    }
//}
//
//class ListItemCell: BaseTableViewCell<ListItem> {
//    private let titleLabel = UILabel()
//    private let subtitleLabel = UILabel()
//    
//    override func setupUI() {
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(subtitleLabel)
//        
//        titleLabel.frame = CGRect(x: 15, y: 5, width: 200, height: 20)
//        subtitleLabel.frame = CGRect(x: 15, y: 25, width: 200, height: 20)
//        subtitleLabel.textColor = .gray
//    }
//    
//    override func bind(_ data: ListItem, index: Int) {
//        titleLabel.text = data.title
//        subtitleLabel.text = data.subtitle
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
