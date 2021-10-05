//
//  PhotoFooter.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/5.
//

import UIKit

class PhotoFooter: UICollectionReusableView {
        
    @IBOutlet weak var addPhotoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addPhotoButton.layer.borderWidth = 1
        addPhotoButton.layer.borderColor = UIColor.quaternaryLabel.cgColor
        addPhotoButton.setTitle("", for: .normal)
    }
}
