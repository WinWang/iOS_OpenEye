import UIKit

//
//  BaseViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/22.
//

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        title = "首页"
        view.backgroundColor = .green
        initView()
        initData()
    }

    /// 初始化View
    public func initView() {}

    /// 初始化数据
    public func initData() {}
}
