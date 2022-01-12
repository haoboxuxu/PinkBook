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
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let typingAttributes: [NSAttributedString.Key : Any] = [
            .paragraphStyle : paragraphStyle,
            .font : UIFont.systemFont(ofSize: 14),
            .foregroundColor : UIColor.secondaryLabel
        ]
        textView.typingAttributes = typingAttributes
        textView.tintColorDidChange()
        
        textView.inputAccessoryView = Bundle.loadView(fromNib: "TextViewIAView", with: TextViewIAView.self)
        textViewIAView.doneButton.addTarget(self, action: #selector(resignTextView), for: .touchUpInside)
        textViewIAView.maxTextCountLabel.text = "/\(kMaxNoteTextCount)"
        
        locationManager.requestWhenInUseAuthorization()
        //隐私合规
        AMapLocationManager.updatePrivacyShow(.didShow, privacyInfo: AMapPrivacyInfoStatus.didContain)
        AMapLocationManager.updatePrivacyAgree(AMapPrivacyAgreeStatus.didAgree)
        AMapSearchAPI.updatePrivacyShow(.didShow, privacyInfo: AMapPrivacyInfoStatus.didContain)
        AMapSearchAPI.updatePrivacyAgree(AMapPrivacyAgreeStatus.didAgree)
        
        print("NSHomeDirectory\(NSHomeDirectory())")
    }
}

extension NoteEditVC {
    @objc private func resignTextView() {
        textView.resignFirstResponder()
    }
}
