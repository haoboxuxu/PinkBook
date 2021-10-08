//
//  ChannelVC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/8.
//

import UIKit
import XLPagerTabStrip

class ChannelVC: ButtonBarPagerTabStripViewController {
    
    var pvDelegate: ChannelVCDelegate?

    override func viewDidLoad() {
        settings.style.selectedBarHeight = 2
        settings.style.selectedBarBackgroundColor = mainColor
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarItemFont = .systemFont(ofSize: 15)
        
        super.viewDidLoad()
        
        containerView.bounces = false
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }

            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .label
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var vcs: [UIViewController] = []
        for index in kAllSubChannels.indices {
            let vc = storyboard?.instantiateViewController(identifier: kChannelTabelVCID) as! ChannelTabelVC
            vc.channel = kChannels[index]
            vc.subChannels = kAllSubChannels[index]
            vcs.append(vc)
        }
        
        return vcs
    }

}
