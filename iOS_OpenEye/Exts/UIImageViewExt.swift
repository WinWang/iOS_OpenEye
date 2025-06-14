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
    
    /// 加载Gif图片
    func showGifImage(_ imageName: String) {
        // 1.加载Gif图片, 并转成Data类型
        guard let path = Bundle.main.path(forResource: imageName + ".gif", ofType: nil) else {
            return
        }
        guard let data = NSData(contentsOfFile: path) else { return }
            
        // 2.从data中读取数据: 将data转成CGImageSource对象
        guard let imageSource = CGImageSourceCreateWithData(data, nil) else { return }
        let imageCount = CGImageSourceGetCount(imageSource)
            
        // 3.遍历所有的图片
        var images = [UIImage]()
        var totalDuration: TimeInterval = 0
        for i in 0 ..< imageCount {
            // 3.1.取出每一帧图片
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else { continue }
            let image = UIImage(cgImage: cgImage)
            if i == 0 {
                self.image = image
            }
            images.append(image)
                
            // 3.2.取出持续的时间
            guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as? NSDictionary else { continue }
            guard let gifDict = properties[kCGImagePropertyGIFDictionary] as? NSDictionary else { continue }
            guard let frameDuration = gifDict[kCGImagePropertyGIFDelayTime] as? NSNumber else { continue }
            totalDuration += frameDuration.doubleValue
        }
            
        // 4.设置imageView的属性
        self.animationImages = images
        self.animationDuration = totalDuration
        self.animationRepeatCount = 0 // 0代表不限重复次数(无限重复)
            
        // 5.开始播放
        self.startAnimating()
    }
}
