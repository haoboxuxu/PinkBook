//
//  HomeVC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/1.
//

import UIKit
import XLPagerTabStrip

class HomeVC: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let followVC = storyboard!.instantiateViewController(identifier: kFollowVCID)
        let nearByVC = storyboard!.instantiateViewController(identifier: kNearByVCID)
        let discoveryVC = storyboard!.instantiateViewController(identifier: kDiscoveryVCID)
        
        return [followVC, nearByVC, discoveryVC]
    }

}
