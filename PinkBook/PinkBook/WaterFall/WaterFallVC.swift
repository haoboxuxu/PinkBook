//
//  WaterFallVC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/1.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import XLPagerTabStrip

class WaterFallVC: UICollectionViewController {
    
    var channel = ""
    
    var draftNotes: [DraftNote] = []
    
    var isDraftNote = true

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        getDraftNotes()
    }

}

// MARK: - CHTCollectionViewDelegateWaterfallLayout
extension WaterFallVC: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellW = (screenRect.height - kWaterFallPadding * 3) / 2
        var cellH: CGFloat = 0
        
        if isDraftNote {
            let draftNote = draftNotes[indexPath.item]
            let imageSize = UIImage(draftNote.coverPhoto)?.size ?? imagePH.size
            let imageH = imageSize.height
            let imageW = imageSize.width
            let imageRatio = imageH / imageW
            cellH = cellW * imageRatio + kDraftNoteWFCellBottomViewH
        } else {
            cellH =  UIImage(named: "ti\(indexPath.item + 1)")!.size.height
        }
        
        return CGSize(width: cellW, height: cellH)
    }
    
}

extension WaterFallVC: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: channel)
    }
}
