//
//  SocailLoginVC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2022/1/12.
//

import UIKit
import AuthenticationServices

class SocailLoginVC: UIViewController {

    @IBOutlet weak var alipayLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alipayLoginBtn.setTitle("", for: .normal)
    }
    
    @IBAction func signInWithAlipay(_ sender: Any) {
        signInWithAlipay()
    }
    
    
    @IBAction func signInWithApple(_ sender: Any) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email, .fullName]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

