//
//  TestStateViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/14.
//
class TestStateViewController: BaseViewController<BaseViewModel> {
    // 标题栏目
    private lazy var titleBar = CommonTitleBar().then { $0.setTitle("页面状态") }
    
    override func initView() {
        addTitleBar(titleBar)
        view.addSubview(stateLayout)
        stateLayout.snp.makeConstraints {
            $0.top.equalTo(titleBar)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func initData() {}
    
    override func initObserver() {
        super.initObserver()
    }
}
