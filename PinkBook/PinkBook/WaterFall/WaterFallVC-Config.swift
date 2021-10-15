//
//  WaterFallVC-Config.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/14.
//

import CHTCollectionViewWaterfallLayout

extension WaterFallVC {
    func config() {
        let layout = collectionView.collectionViewLayout as! CHTCollectionViewWaterfallLayout
        layout.columnCount = 2
        layout.minimumColumnSpacing = kWaterFallPadding
        layout.minimumInteritemSpacing = kWaterFallPadding
        layout.sectionInset = UIEdgeInsets(top: 0, left: kWaterFallPadding, bottom: kWaterFallPadding, right: kWaterFallPadding)
        layout.itemRenderDirection = .shortestFirst
        
        if isDraftNote {
            layout.sectionInset = UIEdgeInsets(top: 44, left: kWaterFallPadding, bottom: kWaterFallPadding, right: kWaterFallPadding)
        }
    }
}
