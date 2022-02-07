//
//  SocailLoginVC-App.swift
//  PinkBook
//
//  Created by 徐浩博 on 2022/1/19.
//

import AuthenticationServices

extension SocailLoginVC: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // let userID = appleIDCredential.user
            
            var name = ""
            if appleIDCredential.fullName?.familyName != nil || appleIDCredential.fullName?.givenName != nil {
                let familyName = appleIDCredential.fullName?.familyName ?? ""
                let givenName = appleIDCredential.fullName?.givenName ?? ""
                name = "\(familyName)\(givenName)"
                UserDefaults.standard.setValue(name, forKey: kNameFromAppleID)
            } else {
                name = UserDefaults.standard.string(forKey: kNameFromAppleID) ?? ""
            }
            
            var email = ""
            if let unwrapedEmail = appleIDCredential.email {
                email = unwrapedEmail
                UserDefaults.standard.setValue(email, forKey: kEmailFromAppleID)
            } else {
                email = UserDefaults.standard.string(forKey: kEmailFromAppleID) ?? ""
            }
            
            print(name, email)
            
            guard let identityToken = appleIDCredential.identityToken,
                  let authorizationCode = appleIDCredential.authorizationCode else { return }
            
            
            print(String(decoding: identityToken, as: UTF8.self))
            print(String(decoding: authorizationCode, as: UTF8.self))
            
        case let passwordCredential as ASPasswordCredential:
            print("passwordCredential")
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign-in-with-Apple失败")
    }
}

extension SocailLoginVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        view.window!
    }
}

extension SocailLoginVC {
    func checkSignInWithAppleState(with userID: String) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userID) { state, error in
            switch state {
            case .revoked:
                print("用户登出或取消")
            case .authorized:
                print("展示正常页面")
            case .notFound:
                print("无登陆，展示登陆页面")
            case .transferred:
                print("")
            @unknown default:
                print("")
            }
        }
    }
}
