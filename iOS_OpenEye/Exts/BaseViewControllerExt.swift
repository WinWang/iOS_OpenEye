//
//  BaseViewControllerExt.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/14.
//

import Combine
import Foundation

extension BaseViewController {
    /// 简化 Combine 订阅的辅助方法
    /// - Parameters:
    ///   - publisher: 要订阅的 Publisher
    ///   - queue: 接收事件的调度队列，默认为主线程
    ///   - handler: 处理接收到的值的闭包
    func subscribe<Output>(
        _ publisher: some Publisher<Output, Never>,
        on queue: DispatchQueue = .main,
        handler: @escaping (Output) -> Void
    ) {
        publisher
            .receive(on: queue)
            .sink(receiveValue: handler)
            .store(in: &cancellables)
    }

    /// 处理可能失败的 Publisher
    func subscribeWithError<Output, Failure: Error>(
        _ publisher: some Publisher<Output, Failure>,
        on queue: DispatchQueue = .main,
        handler: @escaping (Result<Output, Failure>) -> Void
    ) {
        publisher
            .receive(on: queue)
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        handler(.failure(error))
                    }
                },
                receiveValue: { value in
                    handler(.success(value))
                }
            )
            .store(in: &cancellables)
    }
}
