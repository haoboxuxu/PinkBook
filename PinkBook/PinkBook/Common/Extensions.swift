//
//  Extensions.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/3.
//

import UIKit
import MBProgressHUD

extension UITextField {
    var unwrappedText: String { text ?? "" }
}

extension UIView {
    @IBInspectable
    var hbRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            layer.cornerRadius
        }
    }
}

extension UIViewController {
    // MARK: 加载框/提示框
    // MARK: 加载框
    // MARK: 提示
    func showTextHUD(_ title: String, _ subTitle: String? = nil) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true, afterDelay: 2.0)
    }
    
    //点击其他地方收起键盘
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false //防止影响其他cell的点击相应被覆盖
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension Bundle {
    var appName: String {
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            return appName
        } else {
           return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
}
