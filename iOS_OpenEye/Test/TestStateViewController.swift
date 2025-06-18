//
//  TestStateViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/6/14.
//
import Then
import UIKit

class TestStateViewController: BaseViewController<BaseViewModel> {
    // 标题栏目
    private lazy var titleBar = CommonTitleBar().then { $0.setTitle("页面状态") }
    
    private lazy var contentView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
    }
    
    private lazy var successButton = createButton("成功状态") { [weak self] _ in
        self?.viewModel.showSuccess()
    }
    
    private lazy var errorButton = createButton("通用错误状态") { [weak self] _ in
        self?.viewModel.showError()
    }
    
    private lazy var netErrorButton = createButton("网络错误状态") { [weak self] _ in
        self?.viewModel.showNetError()
    }
    
    private lazy var emptyButton = createButton("空态状态") { [weak self] _ in
        self?.viewModel.showEmpty()
    }
    
    private lazy var customButton = createButton("自定义状态") { [weak self] _ in
        self?.viewModel.showCustom(tips: "自定义文案", buttonTips: "Button自定义文案", placeHolder: UIImage(named: "back_placeholder"))
    }
    
    private lazy var loadingButton = createButton("加载中状态") { [weak self] _ in
        self?.viewModel.showLoading()
        self?.updateSuccessState()
    }
    
    override func initView() {
        addTitleBar(titleBar)
        view.addSubview(stateLayout)
        stateLayout.snp.makeConstraints {
            $0.top.equalTo(titleBar.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentView.addArrangedSubview(successButton)
        contentView.addArrangedSubview(errorButton)
        contentView.addArrangedSubview(netErrorButton)
        contentView.addArrangedSubview(emptyButton)
        contentView.addArrangedSubview(customButton)
        contentView.addArrangedSubview(loadingButton)
        
        stateLayout.addContentView(contentView) {
            $0.top.equalToSuperview().offset(20)
            $0.width.equalToSuperview()
        }
        stateLayout.retryCallback = { [weak self] in
            self?.viewModel.showSuccess()
        }
    }
    
    override func initData() {
        updateSuccessState()
    }
    
    override func initObserver() {
        super.initObserver()
    }
    
    /// 更新页面状态
    private func updateSuccessState() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            DispatchQueue.main.async {
                self?.viewModel.viewState = .setSuccess()
            }
        }
    }
}
