//
//  DialogManager.swift
//  iOS_OpenEye
//
//  Created by WinWang on 2025/8/13.
//

import SnapKit
import UIKit

class DialogManager {
    static let shared = DialogManager()
    
    private init() {}
    
    func dialog() -> Builder {
        return Builder()
    }
    
    class Builder {
        private var title: String?
        private var content: String = AppConstant.EMPTY
        private var confirmAction: (() -> Void) = {}
        private var cancelAction: (() -> Void) = {}
        private var confirmText = "确定"
        private var cancelText = "取消"
        private var tapToDismiss = true
        private var showNegativeButton = true
        private var showPositiveButton = true
        
        private weak var targetViewController: UIViewController?
        
        func setTitle(_ title: String?) -> Self {
            self.title = title
            return self
        }
        
        func setContent(_ content: String) -> Self {
            self.content = content
            return self
        }
        
        func setPositiveAction(_ action: @escaping () -> Void) -> Self {
            confirmAction = action
            return self
        }
        
        func setNegativeAction(_ action: @escaping () -> Void) -> Self {
            cancelAction = action
            return self
        }
        
        func setNegativeTitles(_ negativeTitle: String) -> Self {
            cancelText = negativeTitle
            return self
        }
        
        func setPositiveTitle(_ positiveTitle: String) -> Self {
            confirmText = positiveTitle
            return self
        }
        
        func setTapToDismiss(_ enabled: Bool) -> Self {
            tapToDismiss = enabled
            return self
        }
        
        func show(in viewController: UIViewController? = nil) -> Self {
            targetViewController = viewController
            return self
        }
        
        func showNegativeButton(_ show: Bool) -> Self {
            showNegativeButton = show
            return self
        }
        
        func showPositiveButton(_ show: Bool) -> Self {
            showPositiveButton = show
            return self
        }
        
        func show() {
            let targetView: UIView? = {
                if let vc = targetViewController {
                    return vc.view
                } else if let window = UIApplication.shared.currentKeyWindow {
                    return window
                }
                return nil
            }()
            
            guard let targetView = targetView else { return }
            
            let dialog = CustomDialog()
            dialog
                .setTitle(title)
                .setContent(content)
                .setConfirmAction(confirmAction)
                .setCancelAction(cancelAction)
                .showNegativeButton(showButton: showNegativeButton)
                .showPositiveButton(showButton: showPositiveButton)
                .setTapToDismiss(tapToDismiss)
            
            targetView.addSubview(dialog)
            dialog.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            dialog.alpha = 0
            dialog.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3) {
                dialog.alpha = 1
            }
        }
    }
}
