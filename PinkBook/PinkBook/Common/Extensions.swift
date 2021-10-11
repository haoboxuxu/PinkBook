//
//  Extensions.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/3.
//

import UIKit
import MBProgressHUD

extension String {
    var isBlank: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension Optional where Wrapped == String {
    var unwrappedText: String { self ?? "" }
}

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
    func showLoadHUD(_ title: String? = nil) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = title
    }
    
    // MARK: 提示
    func showTextHUD(_ title: String, _ subTitle: String? = nil) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true, afterDelay: 2.0)
    }
    
    func hideLoadHUD() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
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
    
    static func loadView<T>(fromNib name: String, with type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }
        fatalError("加载\(type)view失败")
    }
}
