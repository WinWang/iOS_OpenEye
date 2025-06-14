//
//  ApiServiceType.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/3.
//
import Combine
import Foundation
import Moya

// API服务协议
protocol APIServiceType {
    associatedtype Target: TargetType
    // 网络请求发起的Moya的提供者Provider
    var provider: MoyaProvider<Target> { get }

    // 通用请求，不对返回结果处理，返回原始数据
    // 回调形式
    // func request<T: Decodable>(_ target: Target, completion: @escaping (Result<T, APIError>) -> Void)
    func request<T: Decodable>(_ target: Target, completion: @escaping OneParamUnitAction<Result<T, APIError>>)

    // 通用请求，数据结果响应必须是BaseResponse包裹的类型
    // 回调形式
    // func requestBaseResponse<T: Decodable>(_ target: Target, completion: @escaping (Result<BaseResponse<T>, APIError>) -> Void)
    func requestBaseResponse<T: Decodable>(_ target: Target, completion: @escaping OneParamUnitAction<Result<BaseResponse<T>, APIError>>)
}

extension APIServiceType {
    // 通用解析
    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        // 其他统一配置...
        return decoder
    }

    // 通用请求方法
    func request<T: Decodable>(_ target: Target, completion: @escaping OneParamUnitAction<Result<T, APIError>>) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    // 验证状态码
                    let validatedResponse = try response.filterSuccessfulStatusCodes()
                    // 特殊处理 String 类型
                    if T.self == String.self, let stringResult = String(data: validatedResponse.data, encoding: .utf8) {
                        completion(.success(stringResult as! T))
                        return
                    }
                    // 解析数据
                    let decodedData = try jsonDecoder.decode(T.self, from: validatedResponse.data)
                    completion(.success(decodedData))
                } catch let error as MoyaError {
                    completion(.failure(.serverError(statusCode: error.response?.statusCode ?? 0, message: error.errorDescription)))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            case .failure(let error):
                completion(.failure(handleMoyaError(error)))
            }
        }
    }

    // 针对BaseResponse的请求方法
    func requestBaseResponse<T: Decodable>(_ target: Target, completion: @escaping OneParamUnitAction<Result<BaseResponse<T>, APIError>>) {
        request(target, completion: completion)
    }

    // combine形式
    func requestPublisher<T: Decodable>(_ target: Target) -> AnyPublisher<T, APIError> {
        return Future { promise in
            self.request(target) { result in
                promise(result)
            }
        }
        .receive(on: DispatchQueue.main)
        .handleEvents(receiveSubscription: { _ in
            // 请求开始，可以添加加载状态
        }, receiveCompletion: { _ in
            // 请求结束
        })
        .eraseToAnyPublisher()
    }

    // combine形式
    func requestBasePublisher<T: Decodable>(_ target: Target) -> AnyPublisher<BaseResponse<T>, APIError> {
        return Future { promise in
            self.requestBaseResponse(target) { result in
                promise(result)
            }
        }
        .receive(on: DispatchQueue.main)
        .handleEvents(receiveSubscription: { _ in
            // 请求开始，可以添加加载状态
        }, receiveCompletion: { _ in
            // 请求结束
        })
        .eraseToAnyPublisher()
    }

    // 添加重试功能的版本
    func requestPublisherWithRetry<T: Decodable>(_ target: Target, retryCount: Int = 3) -> AnyPublisher<T, APIError> {
        return requestPublisher(target)
            .retry(retryCount)
            .eraseToAnyPublisher()
    }

    // 错误处理逻辑
    private func handleMoyaError(_ error: MoyaError) -> APIError {
        switch error {
        case .statusCode(let response):
            return .serverError(statusCode: response.statusCode, message: error.errorDescription)
        default:
            return .networkError(error)
        }
    }
}
