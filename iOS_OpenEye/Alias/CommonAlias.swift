import Foundation

//
//  CommonAlias.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/27.
//

/// 单参数无返回值
public typealias NoParamUnitAction = () -> Void
/// 单参数无返回值
public typealias OneParamUnitAction<T> = (T) -> Void
/// 只有一个参数，有返回值的Action
public typealias OneParamResultAction<T, R> = (T) -> R
/// 有两个参数，无返回值
public typealias TwoParamUnitAction<S, T> = (S, T) -> Void
/// 有两个参数，有返回值的Action
public typealias TwoParamResultAction<S, T, R> = (S, T) -> R
/// 有三个参数，无返回值的Action
public typealias ThreeParamUnitAction<R, S, T> = (R, S, T) -> Void
/// 有四个参数，无返回值的Action
public typealias FourParamUnitAction<O, R, S, T> = (O, R, S, T) -> Void
