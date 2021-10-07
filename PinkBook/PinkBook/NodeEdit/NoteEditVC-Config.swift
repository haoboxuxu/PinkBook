//
//  NoteEditVC-Config.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/7.
//

import Foundation

extension NoteEditVC {
    func config() {
        photoCollectionView.dragInteractionEnabled = true
        hideKeyboardWhenTappedAround()
        titleCountLabel.text = "\(kMaxNoteTitleCount)"
        
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -textView.textContainer.lineFragmentPadding,
                                                   bottom: 0, right: -textView.textContainer.lineFragmentPadding)
    }
}
