//
//  SocailLoginVC-Alipay.swift
//  PinkBook
//
//  Created by 徐浩博 on 2022/1/12.
//

import Alamofire

extension SocailLoginVC {
    func signInWithAlipay() {
        
        let infoStr = "apiname=com.alipay.account.auth&app_id=\(kAlipayAppID)&app_name=mc&auth_type=AUTHACCOUNT&biz_type=openservice&method=alipay.open.auth.sdk.code.get&pid=\(kAlipayPID)&product_id=APP_FAST_LOGIN&scope=kuaijie&sign_type=RSA2&target_id=20210122"
        
        guard let signer = APRSASigner(privateKey: kAlipayPrivateKey),
              let signedStr = signer.sign(infoStr, withRSA2: true) else { return }
        
        let authInfoStr = "\(infoStr)&sign=\(signedStr)"
        
        AlipaySDK.defaultService()?.auth_V2(withInfo: authInfoStr, fromScheme: kAppScheme) { res in
            guard let res = res else { return }
            
            //4-6.解析并获取到authCode(授权码)
            let resStatus = res["resultStatus"] as! String
            if resStatus == "9000"{
                
                //"success=true&result_code=200&app_id=2021002125697028&auth_code=38a00948f8054d1ab524d54c295eOE38&scope=kuaijie&alipay_open_id=20881060561109412929791310613838&user_id=2088002401295380&target_id=20210122"
                let resStr = res["result"] as! String
                
                //["success=true","result_code=200","auth_code=xxx",...]
                let resArr = resStr.components(separatedBy: "&")
                
                for subRes in resArr {
                    //subRes长这样:"result_code=200","auth_code=xxx",等等
                    //此处也可用上面的components方法,根据等于号分离成数组,这里使用区间运算符方法
                    let equalIndex = subRes.firstIndex(of: "=")! //等于号的index
                    let equalEndIndex = subRes.index(after: equalIndex) //等于号后面一个字符的index
                    //let prefix = subRes[..<equalIndex] //半开区间-取出等于号前面的内容
                    let suffix = subRes[equalEndIndex...] //闭区间-取出等于号后面的内容
                    //print("\(prefix):\(suffix)")
                    
                    if subRes.hasPrefix("auth_code") {
                        // print("authCode = \(suffix)")
                        self.getToken(String(suffix))
                    }
                }
            }
        }
    }
}

extension SocailLoginVC {
    private func getToken(_ authCode: String) {
        //https://opendocs.alipay.com/apis/api_9/alipay.system.oauth.token
        //请求示例:https://openapi.alipay.com/gateway.do?timestamp=2013-01-01 08:08:08&method=alipay.system.oauth.token&app_id=4472&sign_type=RSA2&sign=ERITJKEIJKJHKKKKKKKHJEREEEEEEEEEEE&version=1.0&charset=GBK&grant_type=authorization_code&code=4b203fe6c11548bcabd8da5bb087a83b
        
        let parameters = [
            "timestamp": Date().format(with: "yyyy-MM-dd HH:mm:ss"),
            "method": "alipay.system.oauth.token",
            "app_id": kAlipayAppID,
            "sign_type": "RSA2",
            "version": "1.0",
            "charset": "utf-8",
            "grant_type": "authorization_code",
            "code": authCode
        ]
        AF.request("https://openapi.alipay.com/gateway.do", parameters: self.signedParameters(parameters)).responseDecodable(of: TokenResponse.self) { response in
            if let tokenResponse = response.value{
                let accessToken = tokenResponse.alipay_system_oauth_token_response.access_token
                //4-7.拿accessToken去和支付宝换用户信息
                self.getInfo(accessToken)
            }
        }
    }
    
    private func getInfo(_ accessToken: String){
        //https://opendocs.alipay.com/apis/api_2/alipay.user.info.share
        //请求示例:https://openapi.alipay.com/gateway.do?timestamp=2013-01-01 08:08:08&method=alipay.user.info.share&app_id=18344&sign_type=RSA2&sign=ERITJKEIJKJHKKKKKKKHJEREEEEEEEEEEE&version=1.0&charset=GBK&auth_token=20130319e9b8d53d09034da8998caefa756c4006
        let parameters = [
            "timestamp": Date().format(with: "yyyy-MM-dd HH:mm:ss"),
            "method": "alipay.user.info.share",
            "app_id": kAlipayAppID,
            "sign_type": "RSA2",
            "version": "1.0",
            "charset": "utf-8",
            "auth_token": accessToken
        ]
        AF.request("https://openapi.alipay.com/gateway.do", parameters: self.signedParameters(parameters)).responseDecodable(of: InfoShareResponse.self){response in
            if let infoShareResponse = response.value{
                let info = infoShareResponse.alipay_user_info_share_response
                print(info.nick_name, info.avatar, info.gender)
                print(info.province, info.city)
            }
        }
    }
}

// MARK: - 辅助函数
extension SocailLoginVC {
    private func signedParameters(_ parameters: [String: String]) -> [String: String] {
        var signedParameters = parameters
        
        //map+sorted后变成:["sign_type=RSA2","version=1.0"]
        //joined后变成:"sign_type=RSA2&version=1.0"
        let urlParameters = parameters.map{ "\($0)=\($1)" }.sorted().joined(separator: "&")
        guard let signer = APRSASigner(privateKey: kAlipayPrivateKey),
              let signedStr = signer.sign(urlParameters, withRSA2: true) else {
            fatalError("加签失败")
        }
        signedParameters["sign"] = signedStr.removingPercentEncoding ?? signedStr
        
        return signedParameters
    }
}

// MARK: - DataModel
extension SocailLoginVC {
    struct TokenResponse: Decodable {
        let alipay_system_oauth_token_response: TokenResponseInfo
        
        struct TokenResponseInfo: Decodable{
            let access_token: String
        }
    }
    
    struct InfoShareResponse: Decodable {
        let alipay_user_info_share_response: InfoShareResponseInfo
        struct InfoShareResponseInfo: Decodable {
            let avatar: String
            let nick_name: String
            let gender: String
            let province: String
            let city: String
        }
    }
}
