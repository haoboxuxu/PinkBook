//
//  SocailLoginVC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2022/1/12.
//

import UIKit

class SocailLoginVC: UIViewController {

    @IBOutlet weak var alipayLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alipayLoginBtn.setTitle("", for: .normal)
    }
    
    @IBAction func signInWithAlipay(_ sender: Any) {
        signInWithAlipay()
    }
}
