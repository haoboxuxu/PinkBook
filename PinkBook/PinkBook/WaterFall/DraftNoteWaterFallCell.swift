//
//  DraftNoteWaterFallCell.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/13.
//

import UIKit

class DraftNoteWaterFallCell: UICollectionViewCell {
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var isVideoImage: UIImageView!
    
    var draftNote: DraftNote? {
        didSet{
            guard let draftNote = draftNote else { return }
            
            imageview.image = UIImage(draftNote.coverPhoto) ?? imagePH
            
            let title = draftNote.title!
            titleLabel.text = title.isEmpty ? "～" : title
            
            dateLabel.text = draftNote.updatedAt?.formattedDate
            
            isVideoImage.isHidden = !draftNote.isVideo
        }
    }
    
}
