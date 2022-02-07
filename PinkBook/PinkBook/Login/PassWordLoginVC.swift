//
//  PassWordLoginVC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2022/2/7.
//

import UIKit

class PassWordLoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backToCodeLoginVC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
