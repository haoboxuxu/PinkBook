//
//  LoginVC-LocalLogin.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/21.
//

import Foundation

extension LoginVC {
    @objc func localLogin() {
        let config = JVAuthConfig()
        config.appKey = kJappKey
        config.authBlock = { (result) -> Void in
            if JVERIFICATIONService.isSetupClient() {
                
            }
        }
        JVERIFICATIONService.setup(with: config)
    }
}
