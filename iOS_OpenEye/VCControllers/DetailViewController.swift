import Foundation
import UIKit

//
//  DetailViewContraller.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/5/26.
//
class DetailViewController: BaseViewController<BaseViewModel> {
    private let id: String

    private lazy var titleBar: CommonTitleBar = {
        let title = CommonTitleBar()
        return title
    }()

    init(id: String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        hidesBottomBarWhenPushed = true
    }

    override func initView() {
        addTitleBar(titleBar)
        titleBar.setTitle(id)
        titleBar.setBackgroundColor(.appPrimary)
    }

    override func initData() {}
}
