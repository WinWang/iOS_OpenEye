//
//  StringExt.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/15.
//

import Foundation

extension String {
    var httpsUrlString: String {
        guard let url = URL(string: self) else { return self }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.scheme = "https"
        return components?.string ?? self
    }
}
