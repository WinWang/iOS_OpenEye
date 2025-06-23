import Kingfisher
import UIKit

//
//  ImageUtils.swift
//  iOS_OpenEye
//  图片加载工具类
//  Created by WinWang on 2025/5/29.
//

// 初始化配置示例
class ImageLoaderConfig {
    static func setupDefaultConfig() {
        // 设置默认占位图
        ImageLoader.Config.defaultPlaceholder = UIImage(named: "back_placeholder")
        
        // 设置默认加载选项
        ImageLoader.Config.defaultOptions = [
            .transition(.fade(0.3)),  // 淡入淡出动画
            .cacheOriginalImage,      // 缓存原始图片
            .backgroundDecode,        // 后台解码
            .alsoPrefetchToMemory,    // 预加载到内存
            .diskCacheExpiration(.days(7)), // 磁盘缓存7天
            .memoryCacheExpiration(.days(1)), // 内存缓存24小时
            .retryStrategy(DelayRetryStrategy(maxRetryCount: 3, retryInterval: .seconds(1))) // 重试策略
        ]
        
        // 设置加载指示器类型
        ImageLoader.Config.defaultIndicatorType = .activity
        
        // 设置重试次数
        ImageLoader.Config.defaultRetryCount = 3
        
        // 配置全局缓存
        let cache = ImageCache.default
        cache.memoryStorage.config.totalCostLimit = 300 * 1024 * 1024  // 300MB内存缓存
        cache.diskStorage.config.sizeLimit = 1000 * 1024 * 1024        // 1GB磁盘缓存
        
        // 配置下载器
        let downloader = ImageDownloader.default
        downloader.downloadTimeout = 15.0  // 15秒超时
    }
}

enum ImageLoader {
    // 全局配置
    enum Config {
        static var defaultPlaceholder: UIImage?
        static var defaultOptions: KingfisherOptionsInfo = [
            .transition(.fade(0.3)),
            .cacheOriginalImage
        ]
        static var defaultIndicatorType: IndicatorType = .activity
        static var defaultRetryCount: Int = 3
    }
    
    static func loadImage(
        for imageView: UIImageView,
        urlString: String?,
        placeholder: UIImage? = Config.defaultPlaceholder,
        options: KingfisherOptionsInfo? = nil,
        retryCount: Int = Config.defaultRetryCount,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil
    ) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            imageView.image = placeholder
            return
        }
        
        imageView.kf.indicatorType = Config.defaultIndicatorType
        
        // 合并默认选项和传入选项
        var allOptions = Config.defaultOptions
        if let options = options {
            allOptions.append(contentsOf: options)
        }
        
        // 添加重试和超时配置
        let processor = DefaultImageProcessor.default
            .append(another: RoundCornerImageProcessor(cornerRadius: 0))
        
        imageView.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: allOptions + [
                .processor(processor),
                .retryStrategy(
                    DelayRetryStrategy(maxRetryCount: retryCount, retryInterval: .seconds(1))
                )
            ],
            completionHandler: completionHandler
        )
    }
    
    // 自定义图片处理
    static func loadRoundedImage(
        for imageView: UIImageView,
        urlString: String?,
        radius: CGFloat = 8.0,
        placeholder: UIImage? = Config.defaultPlaceholder,
        options: KingfisherOptionsInfo? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil
    ) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            imageView.image = placeholder
            return
        }
        
        // 创建圆角处理器
        let processor = RoundCornerImageProcessor(cornerRadius: radius)
                
        // 合并选项，确保处理器不被覆盖
        var allOptions = Config.defaultOptions
        if let options = options {
            allOptions.append(contentsOf: options)
        }
        allOptions.append(.processor(processor))
                
        // 设置视图的圆角（处理占位图和背景）
        imageView.layer.cornerRadius = radius
        imageView.layer.masksToBounds = true
        // 加载图片
        imageView.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: options ?? Config.defaultOptions + [.processor(processor)],
            completionHandler: completionHandler
        )
    }
    
    static func preloadImages(
        urlStrings: [String],
        progressBlock: PrefetcherProgressBlock? = nil,
        completionHandler: PrefetcherCompletionHandler? = nil
    ) {
        let urls = urlStrings.compactMap { URL(string: $0) }
        let prefetcher = ImagePrefetcher(
            urls: urls,
            progressBlock: progressBlock,
            completionHandler: completionHandler
        )
        prefetcher.start()
    }
    
    static func cancelDownload(for imageView: UIImageView) {
        imageView.kf.cancelDownloadTask()
    }
    
    static func clearCache() {
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache()
    }
    
    static func cleanExpiredCache() {
        ImageCache.default.cleanExpiredDiskCache()
    }
    
    // 缓存管理
    static func getCacheSize() -> String {
        let cache = ImageCache.default
        var size = "0 KB"
        
        cache.calculateDiskStorageSize { result in
            switch result {
            case .success(let value):
                let kb = value / 1024
                if kb < 1024 {
                    size = "\(kb) KB"
                } else {
                    let mb = Double(kb) / 1024
                    size = String(format: "%.2f MB", mb)
                }
            case .failure(let error):
                print("Error calculating cache size: \(error)")
            }
        }
        
        return size
    }
}
