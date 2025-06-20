//
//  HotViewModel.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/23.
//
class HotViewModel :BaseViewModel{
    
    // title列表
    lazy var hotTitle: [HotTitleModel] = [
        HotTitleModel(title: "周排行", type: "weekly"),
        HotTitleModel(title: "月排行", type: "monthly"),
        HotTitleModel(title: "总排行", type: "historical")
    ]
}
