//
//  BaseTableAdapter.swift
//  iOS_OpenEye。   Section Header和Footer类似Cell一样注册事项
//
//  Created by WinWang on 2025/6/18.
//

import UIKit

// 定义Header/Footer复用标识
private let HeaderFooterReuseIdentifier = "SectionHeaderFooterView"

// Header/Footer配置协议
protocol SectionHeaderFooterConfigurable {
    associatedtype HeaderFooterData
    func configure(section: Int, data: HeaderFooterData?)
}

// 基础Header/Footer视图
class BaseSectionHeaderFooterView<T>: UITableViewHeaderFooterView, SectionHeaderFooterConfigurable {
    typealias HeaderFooterData = T
    
    func configure(section: Int, data: T?) {
        // 子类实现具体配置
    }
}

// Section数据模型
struct SectionModel<T: BaseItem, H, F> {
    var items: [T]
    var headerData: H?
    var footerData: F?
}

// 基础TableView适配器
class BaseTableSectionAdapter<T: BaseItem, H, F>: NSObject, UITableViewDataSource, UITableViewDelegate {
    private(set) var tableView: UITableView?
    private(set) var sections: [SectionModel<T, H, F>] = []
    weak var delegate: BaseTableViewAdapterDelegate?
    
    // Cell类型字典
    private var cellTypeDict: [Int: UITableViewCell.Type] = [:]
    
    // Header/Footer配置
    private var headerConfig: [Int: (view: BaseSectionHeaderFooterView<H>.Type, height: CGFloat)] = [:]
    private var footerConfig: [Int: (view: BaseSectionHeaderFooterView<F>.Type, height: CGFloat)] = [:]
    
    var onItemClick: ((IndexPath, T) -> Void)?
    var onItemLongPress: ((IndexPath, T) -> Void)?
    
    // 注册Header视图
    func registerHeader<Header: BaseSectionHeaderFooterView<H>>(_ headerType: Header.Type, height: CGFloat, forSection section: Int) {
        headerConfig[section] = (view: headerType, height: height)
    }
    
    // 注册Footer视图
    func registerFooter<Footer: BaseSectionHeaderFooterView<F>>(_ footerType: Footer.Type, height: CGFloat, forSection section: Int) {
        footerConfig[section] = (view: footerType, height: height)
    }
    
    func setNewData(_ data: [SectionModel<T, H, F>]) {
        self.sections = data
        self.tableView?.reloadData()
    }
    
    func addData(_ data: [T], toSection section: Int) {
        if section < sections.count {
            sections[section].items.append(contentsOf: data)
            self.tableView?.reloadSections(IndexSet(integer: section), with: .automatic)
        }
    }
    
    func register<Cell: BaseTableViewCell<U>, U: BaseItem>(cellType: Cell.Type, forItemType itemType: Int) {
        cellTypeDict[itemType] = cellType
    }
    
    func bindTableView(_ tableView: UITableView) {
        // 注册Cell
        for (_, cellType) in cellTypeDict {
            tableView.register(cellType, forCellReuseIdentifier: String(describing: cellType))
        }
        
        // 注册所有Header/Footer类型
        // 使用Dictionary的values转为数组来避免Set的Hashable要求
        let headerTypes = Array(headerConfig.values.map { $0.view })
        let footerTypes = Array(footerConfig.values.map { $0.view })
        
        for headerType in headerTypes {
            tableView.register(headerType, forHeaderFooterViewReuseIdentifier: String(describing: headerType))
        }
        
        for footerType in footerTypes {
            tableView.register(footerType, forHeaderFooterViewReuseIdentifier: String(describing: footerType))
        }
        
        self.tableView = tableView
    }
    
    func getItem(at indexPath: IndexPath) -> T? {
        guard indexPath.section < sections.count,
              indexPath.row < sections[indexPath.section].items.count else { return nil }
        return sections[indexPath.section].items[indexPath.row]
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].items[indexPath.row]
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
        guard let config = headerConfig[section] else { return nil }
        
        let identifier = String(describing: config.view)
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? BaseSectionHeaderFooterView<H>
        headerView?.configure(section: section, data: sections[section].headerData)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let config = footerConfig[section] else { return nil }
        
        let identifier = String(describing: config.view)
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? BaseSectionHeaderFooterView<F>
        footerView?.configure(section: section, data: sections[section].footerData)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerConfig[section]?.height ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerConfig[section]?.height ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = sections[indexPath.section].items[indexPath.row]
        delegate?.onItemClick(indexPath: indexPath, itemData: item)
        onItemClick?(indexPath, item)
    }
    
    func tableView(_ tableView: UITableView, didLongPressRowAt indexPath: IndexPath) {
        let item = sections[indexPath.section].items[indexPath.row]
        delegate?.onItemLongPress(indexPath: indexPath, itemData: item)
        onItemLongPress?(indexPath, item)
    }
}

// MARK: - 使用示例

// 1. 创建自定义Header数据模型
//struct HeaderModel {
//    let id: Int
//    let icon: String
//    let title: String
//    let description: String
//}
//
//// 2. 创建自定义Cell
//class CustomTableViewCell: BaseTableViewCell<CustomItem> {
//    override func bindData(_ item: CustomItem, index: Int) {
//        // 配置cell UI
//    }
//}
//
//// 3. 创建自定义Header
//class CustomHeaderView: BaseSectionHeaderFooterView<HeaderModel> {
//    override func configure(section: Int, data: HeaderModel?) {
//        // 配置header UI，可以使用data中的数据
//    }
//}
//
//// 4. 创建数据模型
//class CustomItem: BaseItem {
//    var title: String
//    
//    init(title: String, itemType: Int) {
//        self.title = title
//        super.init()
//        self.itemType = itemType
//    }
//}
//
//// 5. 在ViewController中使用
//class ViewController: UIViewController {
//    private let tableView = UITableView()
//    private let adapter = BaseTableSectionViewAdapter<CustomItem, HeaderModel, Never>()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // 设置tableView
//        view.addSubview(tableView)
//        
//        // 注册cell和header
//        adapter.register(cellType: CustomTableViewCell.self, forItemType: 1)
//        adapter.registerHeader(CustomHeaderView.self, height: 50, forSection: 0)
//        
//        // 绑定tableView
//        adapter.bindTableView(tableView)
//        
//        // 设置点击回调
//        adapter.onItemClick = { indexPath, item in
//            print("点击了第\(indexPath.section)组第\(indexPath.row)行")
//        }
//        
//        // 添加数据
//        let sections = [
//            SectionModel(
//                items: [
//                    CustomItem(title: "Section 0 Row 0", itemType: 1),
//                    CustomItem(title: "Section 0 Row 1", itemType: 1)
//                ],
//                headerData: HeaderModel(
//                    id: 2142,
//                    icon: "http://example.com/icon.jpg",
//                    title: "骑士录",
//                    description: "一部冒险式专业化的短途摩旅纪录片"
//                ),
//                footerData: nil
//            )
//        ]
//        adapter.setNewData(sections)
//    }
//}

