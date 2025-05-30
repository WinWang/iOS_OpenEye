//
//  ToastUtils.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/30.
//
import Toast
import UIKit

func showToast(
    _ msg: String,
    duration: TimeInterval = 3.0,
    position: ToastPosition = ToastPosition.center,
    title: String? = nil,
    image: UIImage? = nil,
    style: ToastStyle = ToastManager.shared.style,
    completion: ((_ didTap: Bool) -> Void)? = nil
) {
    UIViewController.topMost?.navigationController?.view.makeToast(
        msg,
        duration: duration,
        position: position,
        title: title,
        image: image,
        style: style,
        completion: completion
    )
}
