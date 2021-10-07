//
//  TextViewIAView.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/7.
//

import UIKit

class TextViewIAView: UIView {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var textCountStackView: UIStackView!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var maxTextCountLabel: UILabel!
    
    var currentTextCount = 0 {
        didSet {
            if currentTextCount <= kMaxNoteTextCount {
                doneButton.isHidden = false
                textCountStackView.isHidden = true
            } else {
                doneButton.isHidden = true
                textCountStackView.isHidden = false
                textCountLabel.text = "\(currentTextCount)"
            }
        }
    }
}
