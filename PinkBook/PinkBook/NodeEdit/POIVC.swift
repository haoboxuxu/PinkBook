//
//  POIVC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/8.
//

import UIKit

class POIVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension POIVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    
}

extension POIVC: UITableViewDelegate {
    
}
