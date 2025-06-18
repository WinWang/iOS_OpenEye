import Combine
import Foundation
import ObjectiveC
import UIKit

//
//  BaseViewModel.swift
//  iOS_OpenEye
//  基础ViewModel类
//
//  Created by WinWang on 2025/5/23.
//
// 定义协议，强制检验必须有基础无餐构造
protocol Initializable {
    init()
}

class BaseViewModel: ObservableObject, Initializable {
    // 页面UI布局加载状态
    @Published
    var viewState: ViewState = .setViewState()

    // combine统一订阅销毁管理
    var cancellables = Set<AnyCancellable>()

    required init() {
        let className = String(describing: type(of: self))
        logDebug("ViewModel初始化->[\(className)] initialized")
    }

    // 封装网络请求方法
    // -publisher           网络请求发布者
    // -showStateLoading    是否展示StateLayout的loading
    // -showStateError      是否展示StateLayout的Error
    // -success             成功回调
    // -error               错误回调
    func httpRequest<T: Codable>(
        _ publisher: AnyPublisher<T, APIError>,
        showStateLoading: Bool = true,
        showStateError: Bool = true,
        success successHandler: @escaping OneParamUnitAction<T>,
        error errorHandler: OneParamUnitAction<APIError>? = nil
    ) {
        // 更新状态为加载中
        if showStateLoading {
            viewState = ViewState.setViewState()
        }
        publisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        // 请求成功完成，不需要额外操作
                        break
                    case .failure(let error):
                        
                        self?.viewState = ViewState(state: .error, tips: error.localizedDescription)

                        errorHandler?(error)
                    }
                },
                receiveValue: { [weak self] value in
                    // 请求成功，更新状态为成功并传递数据
                    self?.showSuccess()
                    successHandler(value)
                }
            )
            .store(in: &cancellables)
    }

    // 可选：提供更简化的方法
    func simpleHttpRequest<T: Codable>(_ publisher: AnyPublisher<T, APIError>) {
        httpRequest(publisher) { _ in
            // 默认不处理成功数据
        } error: { _ in
            // 默认不处理错误
        }
    }

    /// 页面状态修改-成功
    func showSuccess() {
        viewState = ViewState.setSuccess()
    }

    /// 错误
    func showError() {
        viewState = ViewState.setError()
    }

    /// 错误
    func showNetError() {
        viewState = ViewState.setNetworkError()
    }

    /// 空态
    func showEmpty() {
        viewState = ViewState.setEmpty()
    }

    /// 加载中
    func showLoading() {
        viewState = ViewState.setViewState()
    }

    /// 自定义布局展示
    func showCustom(
        tips: String = AppConstant.EMPTY,
        buttonTips: String = AppConstant.EMPTY,
        placeHolder: UIImage?
    ) {
        viewState = ViewState.setCustom(tips: tips, buttonTips: buttonTips, placeHolder: placeHolder)
    }
}
