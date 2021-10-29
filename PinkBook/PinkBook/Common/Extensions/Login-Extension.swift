//
//  LoginVC-LocalLogin.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/21.
//

import Foundation
import Alamofire

extension UIViewController {
    @objc func localLogin() {
        
        showLoadHUD()
        
        let config = JVAuthConfig()
        config.appKey = kJappKey
        config.authBlock = { (result) -> Void in
            if JVERIFICATIONService.isSetupClient() {
                //预取号
                JVERIFICATIONService.preLogin(5000) { (result) in
                    self.hideLoadHUD()
                    if let result = result, let code = result["code"] as? Int, code == 7000 {
                        //可预取号
                        self.setLocalLoginUI()
                        self.presentLocalLoginVC()
                    } else {
                        //不可预取号
                        //print("预取号失败，错误码 \(result!["code"]), 错误描述 \(result!["content"])")
                        self.presentCodeLoginVC()
                    }
                }
            } else {
                self.hideLoadHUD()
                print("一键登录初始化失败")
                //self.presentCodeLoginVC()
            }
        }
        JVERIFICATIONService.setup(with: config)
    }
    
    private func presentLocalLoginVC() {
        JVERIFICATIONService.getAuthorizationWith(self, hide: true, animated: true, timeout: 5*1000, completion: { (result) in
            if let result = result, let loginToken = result["loginToken"] as? String {
                JVERIFICATIONService.clearPreLoginCache()
                print("loginToken = \(loginToken)")
                self.getEncryptedPhontNum(loginToken)
            } else {
                print("一键登录失败了")
                self.otherLogin()
            }
        }) { (type, content) in
            if let content = content {
                print("一键登录 actionBlock :type = \(type), content = \(content)")
            }
        }
    }
}

extension UIViewController {
    @objc private func otherLogin() {
        JVERIFICATIONService.dismissLoginController(animated: true) {
            self.presentCodeLoginVC()
        }
    }
    
    @objc private func dismissLocalLoginVC() {
        JVERIFICATIONService.dismissLoginController(animated: true, completion: nil)
    }
}

extension UIViewController {
    private func presentCodeLoginVC() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavC = mainStoryboard.instantiateViewController(identifier: kLoginNavID)
        loginNavC.modalPresentationStyle = .fullScreen
        present(loginNavC, animated: true)
    }
}

extension UIViewController {
    private func setLocalLoginUI() {
        let config = JVUIConfig()
        
        config.prefersStatusBarHidden = true
        config.navTransparent = true
        config.navText = NSAttributedString(string: " ")
        config.navReturnHidden = true
        config.navControl = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(dismissLocalLoginVC))
        
        let constraintX = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        
        let logoConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1/7, constant: 0)
        config.logoConstraints = [constraintX!, logoConstraintY!]
        
        let numberConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 35)
        config.numberConstraints = [constraintX!, numberConstraintY!]
        
        let sloganConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.number, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 35)
        config.sloganConstraints = [constraintX!, sloganConstraintY!]
        
        config.logBtnText = "同意协议并一键登录"
        config.logBtnImgs = [UIImage(named: "localLoginBtn-nor")!,
                             UIImage(named: "localLoginBtn-nor")!,
                             UIImage(named: "localLoginBtn-hig")!]
        
        let logBtnConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.slogan, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 50)
        config.logBtnConstraints = [constraintX!, logBtnConstraintY!]
        
        config.privacyState = true
        config.checkViewHidden = true
        
        config.appPrivacyOne = ["用户协议", "https://www.apple.com/cn/"]
        config.appPrivacyTwo = ["隐私政策", "https://www.apple.com/cn/"]
        config.privacyComponents = ["登陆注册代表你同意", "以及", "和", " "]
        config.privacyTextAlignment = .center
        config.appPrivacyColor = [UIColor.secondaryLabel, bluedColor]
        
        let privacyConstraintW = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.none, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 260)
        let privacyConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -70)
        config.privacyConstraints = [constraintX!, privacyConstraintY!, privacyConstraintW!]
        
        config.agreementNavBackgroundColor = mainColor
        config.agreementNavReturnImage = UIImage(systemName: "chevron.left")
        
        JVERIFICATIONService.customUI(with: config) { customView in
            guard let customView = customView else { return }
            
            let otherLoginBtn = UIButton()
            otherLoginBtn.setTitle("其他方式登陆", for: .normal)
            otherLoginBtn.setTitleColor(.secondaryLabel, for: .normal)
            otherLoginBtn.titleLabel?.font = .systemFont(ofSize: 15)
            otherLoginBtn.translatesAutoresizingMaskIntoConstraints = false
            otherLoginBtn.addTarget(self, action: #selector(self.otherLogin), for: .touchUpInside)
            customView.addSubview(otherLoginBtn)
            
            NSLayoutConstraint.activate([
                otherLoginBtn.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
                otherLoginBtn.centerYAnchor.constraint(equalTo: customView.centerYAnchor, constant: 170),
                otherLoginBtn.widthAnchor.constraint(equalToConstant: 279)
            ])
        }
    }
}

extension UIViewController {
    
    struct LocalLoginRes: Decodable {
        let phone: String
    }
    
    private func getEncryptedPhontNum(_ loginToken: String) {
        let headers: HTTPHeaders = [
            .authorization(username: "62e763e9ad535f7ec0e49858", password: "ccf97fdc9e56d5aeebef8f0e")
        ]
        
        let parameters = ["loginToken" : loginToken]
        
        AF.request(
            "https://api.verification.jpush.cn/v1/web/loginTokenVerify",
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ).responseDecodable(of: LocalLoginRes.self) { response in
            if let localLoginRes = response.value {
                print("localLoginRes.phone = \(localLoginRes.phone)")
            }
        }
    }
}
