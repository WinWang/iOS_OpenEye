import UIKit

//
//  BaseViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/22.
//

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        initUI()
        // 初始化View
        initView()
        // 初始化数据
        initData()
    }

    /// 初始化View
    public func initView() {}

    /// 初始化数据
    public func initData() {}

    /// 初始化父组件UI
    private func initUI() {
        // 全局背景色默认白色
        view.backgroundColor = .white
        // 隐藏UINavigationController
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
