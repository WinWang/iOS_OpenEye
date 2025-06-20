//
//  BaseListProtocal.swift
//  iOS_OpenEye 列表类基础协议
//
//  Created by WinWang on 2025/6/19.
//

import Foundation

// 基础TableView适配器协议
public protocol BaseTableViewAdapterDelegate: AnyObject {
    func onItemClick(indexPath: IndexPath, itemData: BaseItem)
    func onItemLongPress(indexPath: IndexPath, itemData: BaseItem)
}

// 基础数据模型协议
public protocol BaseItem {
    var itemType: Int? { get set}
}

// 基础Cell绑定协议
protocol CellBindable {
    func bindData(_ data: BaseItem,index:Int)
}

/**
 *基础String BaseItem*
 */
class BaseStringItem : BaseItem{
    var itemType: Int? = 0
    
    var label :String = "0"
}
