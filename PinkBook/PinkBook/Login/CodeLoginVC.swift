//
//  CodeLoginVC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2022/2/7.
//

import UIKit

private let totalTime = 10
class CodeLoginVC: UIViewController {
    
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var authCodeTF: UITextField!
    @IBOutlet weak var getAuthCodeBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    private var timeRemain = totalTime
    
    lazy var timer = Timer()
    
    private var phoneNumberStr: String {
        return phoneNumberTF.unwrappedText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAuthCodeBtn.isHidden = true
        hideKeyboardWhenTappedAround()
        loginBtn.setToDisabled()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        phoneNumberTF.becomeFirstResponder()
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tfEditingChanged(_ sender: Any) {
        getAuthCodeBtn.isHidden = !phoneNumberStr.isPhoneNumber
    }
    
    @IBAction func getAuthCode(_ sender: Any) {
        getAuthCodeBtn.isEnabled = false
        setAuthCodeBtnDisabledText()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeAuthCodeBtnText), userInfo: nil, repeats: true)
    }
    
    @IBAction func login(_ sender: Any) {
        
    }
}

extension CodeLoginVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let limit = textField == phoneNumberTF ? 11 : 6
        let isExceed = range.location >= limit || (textField.unwrappedText.count + string.count) > limit
        return !isExceed
    }
}

extension CodeLoginVC {
    @objc func changeAuthCodeBtnText() {
        timeRemain -= 1
        setAuthCodeBtnDisabledText()
        
        if timeRemain <= 0 {
            timer.invalidate()
            timeRemain = totalTime
            getAuthCodeBtn.isEnabled = true
            getAuthCodeBtn.setTitle("发送验证码", for: .normal)
        }
    }
    
    private func setAuthCodeBtnDisabledText() {
        getAuthCodeBtn.setTitle("重新发送(\(timeRemain))s", for: .disabled)
    }
}
