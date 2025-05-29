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
