//
//  Extensions.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/3.
//

import UIKit
import MBProgressHUD
import DateToolsSwift

extension String {
    var isBlank: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension Optional where Wrapped == String {
    var unwrappedText: String { self ?? "" }
}

extension Date {
    var formattedDate: String {
        let currentYear = Date().year
        if self.year == currentYear {
            if isToday {
                if minutesAgo > 10 {
                    return "今天\(format(with: "HH:mm"))"
                } else {
                    return timeAgoSinceNow
                }
            } else if isYesterday {
                return "昨天\(format(with: "HH:mm"))"
            } else {
                return format(with: "MM:dd")
            }
        } else if year < currentYear {
            return format(with: "yyyy-MM-dd")
        } else {
            return "未来闪电侠"
        }
    }
}

extension UIImage {
    
    convenience init?(_ data: Data?) {
        if let unwrappedData = data {
            self.init(data: unwrappedData)
        } else {
            return nil
        }
    }
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

extension UITextField {
    var unwrappedText: String { text ?? "" }
    var exactText: String {
        unwrappedText.isBlank ? "" : unwrappedText
    }
}

extension UITextView {
    var unwrappedText: String { text ?? "" }
    var exactText: String {
        unwrappedText.isBlank ? "" : unwrappedText
    }
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
