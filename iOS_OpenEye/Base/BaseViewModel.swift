import Combine
import Foundation
import ObjectiveC

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

class BaseViewModel: NSObject, Initializable {
    // 页面UI布局加载状态
    @Published
    var viewState: ViewState = .setViewState()

    // combine统一订阅销毁管理
    var cancellables = Set<AnyCancellable>()

    override required init() {
        print("BaseViewModel initialized")
    }

    // 封装网络请求方法
    func httpRequest<T: Codable>(
        _ publisher: AnyPublisher<T, APIError>,
        success successHandler: @escaping OneParamUnitAction<T>,
        error errorHandler: OneParamUnitAction<APIError>? = nil
    ) {
        // 更新状态为加载中
        viewState = ViewState.setViewState()
        publisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        // 请求成功完成，不需要额外操作
                        break
                    case .failure(let error):
                        // 请求失败，更新状态为错误
                        self?.viewState = ViewState(state: .error, tips: error.localizedDescription)
                        errorHandler?(error)
                    }
                },
                receiveValue: { [weak self] value in
                    // 请求成功，更新状态为成功并传递数据
                    self?.viewState = ViewState.setSuccess()
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
}
