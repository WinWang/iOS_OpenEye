import Kingfisher
import UIKit

//
//  UIImageViewExt.swift
//  iOS_OpenEye
//  图片拓展函数
//
//  Created by WinWang on 2025/5/29.
//
extension UIImageView {
    /// 加载图片
    func loadImage(
        _ urlString: String?,
        placeholder: UIImage? = ImageLoader.Config.defaultPlaceholder,
        options: KingfisherOptionsInfo? = nil,
        retryCount: Int = ImageLoader.Config.defaultRetryCount,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil
    ) {
        ImageLoader.loadImage(
            for: self,
            urlString: urlString,
            placeholder: placeholder,
            options: options,
            retryCount: retryCount,
            completionHandler: completionHandler
        )
    }

    /// 加载圆角图片
    func loadRoundedImage(
        _ urlString: String?,
        radius: CGFloat = 8.0,
        placeholder: UIImage? = ImageLoader.Config.defaultPlaceholder,
        options: KingfisherOptionsInfo? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil
    ) {
        ImageLoader.loadRoundedImage(
            for: self,
            urlString: urlString,
            radius: radius,
            placeholder: placeholder,
            options: options,
            completionHandler: completionHandler
        )
    }

    /// 取消图片下载
    func cancelImageDownload() {
        ImageLoader.cancelDownload(for: self)
    }
}
