//
//  FocusVewModel.swift
//  iOS_OpenEye
//  关注模块ViewModel
//
//  Created by WinWang on 2025/6/19.
//
import Foundation

class FocusViewModel :BaseViewModel{
    
    var pageIndex:Int = 0
    
    @Published
    var focusList : [FocusModelItemList] = []
    
    func getFocusList(){
        httpRequest(
        ApiManager.shared.openEyeService.getFocusList(pageIndex: pageIndex),
        showStateLoading: pageIndex==0,showStateError: pageIndex==0,
        success: { [weak self] focusData in
            self?.focusList = focusData.itemList ?? []
        },
        error: { error in
            logDebug("网络请求错误\(String(describing: error.errorDescription))")
        }
    )}
}
