//
//  CustomeListPlayerControllerView.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/8/8.
//

import UIKit
import BMPlayer

class CustomeListPlayerControllerView  : BMPlayerControlView{
    
    
    override func customizeUIComponents() {
        backButton.isHidden = true
    }
    
}
