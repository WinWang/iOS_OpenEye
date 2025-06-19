//
//  CategoryViewModel.swift
//  iOS_OpenEye 分类ViewModel
//
//  Created by WinWang on 2025/6/19.
//

import Combine
import Foundation

class CategoryViewModel :BaseViewModel{
    
    @Published
    var categogyList :[CategoryModelChild] = []
    
    //接口请求分类数据
    func getCategoryList(){
        httpRequest(ApiManager.shared.openEyeService.getCategoryList()){[weak self] result in
            self?.categogyList = result.categoryList ?? []
        }
    }
}
