//
//  BaseViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/22.
//
import Combine
import UIKit

class BaseViewController<T: BaseViewModel & Initializable>: UIViewController {
    // 占位UI-根据需要是否使用StateLayout 实例
    lazy var stateLayout = StateLayout()
    // 基类ViewModel
    lazy var viewModel = createViewModel()
    // combine统一订阅销毁管理
    var cancellables = Set<AnyCancellable>()

    func createViewModel() -> T {
        return T()
    }

    override func viewDidLoad() {
        initUI()
        // 初始化View
        initView()
        // 初始化数据
        initData()
        // 创建观察者
        initObserver()
    }

    /// 初始化View
    public func initView() {}

    /// 初始化数据
    public func initData() {}

    /// 创建观察者
    public func initObserver() {
        initStateObserver()
    }

    /// 初始化父组件UI
    private func initUI() {
        // 全局背景色默认白色
        view.backgroundColor = .white
        // 隐藏UINavigationController
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    /// 页面状态观测
    private func initStateObserver() {
        viewModel.$viewState
            .receive(on: DispatchQueue.main) // 确保在主线程更新 UI
            .sink { [weak self] viewState in
                self?.stateLayout.viewState = viewState
            }.store(in: &cancellables)
    }
}
