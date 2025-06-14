import IGListKit
import UIKit

//
//  DiscoverViewController.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/23.
//

class DiscoverViewController: BaseViewController<DiscoverViewModel> {
    // 标题栏
//    private lazy var titleBar = {
//        let titleBar = CommonTitleBar()
//        titleBar.setBackButtonVisibility(false)
//        titleBar.setTitle("发现")
//        return titleBar
//    }()
//
//    override func initView() {
//        addTitleBar(titleBar)
//    }
//
//    override func initData() {}
    
    // 模拟数据加载状态
    private var isLoading = false
    private var dataLoaded = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupStateLayout()
        loadData()
    }
        
    private func setupStateLayout() {
        // 添加StateLayout到视图
        view.addSubview(stateLayout)
        stateLayout.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
            
        // 设置内容视图 - 包含滚动视图和复杂表单
        setupFormLayout()
            
        // 设置重试回调
        stateLayout.retryCallback = { [weak self] in
            self?.loadData()
        }
    }
        
    private func setupFormLayout() {
        // 清除现有内容
        stateLayout.clearContentViews()
            
        // 创建滚动视图作为内容根视图
        let scrollView = UIScrollView()
        let contentView = UIView()
            
        // 添加滚动视图到StateLayout
        stateLayout.addContentView(scrollView) { make in
            make.edges.equalToSuperview()
        }
            
        // 设置滚动视图约束
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
            
        // 设置滚动视图内容视图约束
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
            
        // 添加表单元素
        addFormElements(to: contentView)
    }
        
    private func addFormElements(to container: UIView) {
        // 标题标签
        let titleLabel = UILabel()
        titleLabel.text = "用户信息表单"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        container.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
        }
            
        // 头像视图
        let avatarView = UIView()
        avatarView.backgroundColor = .systemGray3
        avatarView.layer.cornerRadius = 50
        container.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
            
        // 用户名输入框
        let nameTextField = UITextField()
        nameTextField.placeholder = "请输入用户名"
        nameTextField.borderStyle = .roundedRect
        container.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(avatarView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
            
        // 邮箱输入框
        let emailTextField = UITextField()
        emailTextField.placeholder = "请输入邮箱"
        emailTextField.borderStyle = .roundedRect
        container.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(15)
            make.leading.trailing.height.equalTo(nameTextField)
        }
            
        // 提交按钮
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("提交表单", for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 8
        container.addSubview(submitButton)
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-30) // 确保底部有边距
        }
    }
        
    private func loadData() {
        // 显示加载状态
        stateLayout.viewState = ViewState(state: .loading)
            
        // 模拟网络请求
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            self.isLoading = false
                
            // 模拟50%的成功率
            self.dataLoaded = arc4random_uniform(2) == 0
                
            if self.dataLoaded {
                // 数据加载成功
                self.stateLayout.viewState = ViewState(state: .success)
            } else {
                // 数据加载失败
                self.stateLayout.viewState = ViewState(state: .error)
            }
        }
    }
}
