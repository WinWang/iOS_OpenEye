import UIKit

//
//  Colors.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/26.
//

extension UIColor {
    // 使用静态属性定义全局颜色
    static let appPrimary = UIColor(hex: "#D81E06")
    static let appSecondary = UIColor(red: 87/255, green: 87/255, blue: 87/255, alpha: 1)
    static let color_C7CBD1 = UIColor(hex: "#C7CBD1")
    static let color_2C2C2C = UIColor(hex: "#2C2C2C")
    static let color_000000 = UIColor(hex: "#000000")
    static let color_111111 = UIColor(hex: "#111111")
    static let color_222222 = UIColor(hex: "#222222")
    static let color_333333 = UIColor(hex: "#333333")
    static let color_444444 = UIColor(hex: "#444444")
    static let color_555555 = UIColor(hex: "#555555")
    static let color_666666 = UIColor(hex: "#666666")
    static let color_777777 = UIColor(hex: "#777777")
    static let color_888888 = UIColor(hex: "#888888")
    static let color_999999 = UIColor(hex: "#999999")
    static let color_FFFFFF = UIColor(hex: "#FFFFFF")
    static let color_F6F6F6 = UIColor(hex: "#F6F6F6")
    static let color_F8F8F8 = UIColor(hex: "#F8F8F8")
    
    // 如果需要使用十六进制颜色，可以添加便利构造器
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
            
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
            
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
            
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16)/255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8)/255.0,
            blue: CGFloat(rgbValue & 0x0000FF)/255.0,
            alpha: alpha
        )
    }
}
