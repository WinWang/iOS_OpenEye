//
//  StringExt.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/15.
//

import Foundation

extension String {
    /// 将http链接替换成https链接
    var httpsUrlString: String {
        guard let url = URL(string: self) else { return self }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.scheme = "https"
        return components?.string ?? self
    }
    
    /// 将img域名替换为ali-img域名
    var aliImgUrlString: String {
        guard !self.isEmpty else { return self }
        
        let pattern = "^(https?://)(img\\.)(.*)$"
        let replacement = "$1ali-img.$3"
        
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            let range = NSRange(location: 0, length: self.count)
            return regex.stringByReplacingMatches(in: self,
                                                options: [],
                                                range: range,
                                                withTemplate: replacement)
        }
        return self
    }
    
}
