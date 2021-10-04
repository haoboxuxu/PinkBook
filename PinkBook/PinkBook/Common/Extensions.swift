//
//  Extensions.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/3.
//

import Foundation

extension Bundle {
    var appName: String {
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            return appName
        } else {
           return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
}
