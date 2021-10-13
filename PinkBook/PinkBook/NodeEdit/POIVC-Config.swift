//
//  POIVC-Config.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/10.
//

import UIKit

extension POIVC {
    func config() {
        mapSearch?.delegate = self
        
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //   定位超时时间，最低2s，此处设置为2s
        locationManager.locationTimeout = 5
        //   逆地理请求超时时间，最低2s，此处设置为2s
        locationManager.reGeocodeTimeout = 5
        
        // 上拉刷新poi数据
        tableView.mj_footer = footer
        
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
    }
}
