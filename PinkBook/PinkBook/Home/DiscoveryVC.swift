//
//  DiscoveryVC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/1.
//

import UIKit
import XLPagerTabStrip

class DiscoveryVC: UIViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: "发现")
    }
}
