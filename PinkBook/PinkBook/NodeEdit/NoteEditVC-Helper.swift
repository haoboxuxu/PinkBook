//
//  NoteEditVC-Helper.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/16.
//

extension NoteEditVC {
    func validateNote() {
        guard !photos.isEmpty else {
            showTextHUD("至少需要一张照片")
            return
        }
        
        guard textViewIAView.currentTextCount <= kMaxNoteTextCount else {
            showTextHUD("正文最多输入\(kMaxNoteTextCount)个字")
            return
        }
    }
    
    func handleTFEditChanged() {
        guard titleTextField.markedTextRange == nil else { return }
        if titleTextField.unwrappedText.count > kMaxNoteTitleCount {
            titleTextField.text = String(titleTextField.unwrappedText.prefix(kMaxNoteTitleCount))
            
            DispatchQueue.main.async {
                let end = self.titleTextField.endOfDocument
                self.titleTextField.selectedTextRange = self.titleTextField.textRange(from: end, to: end)
            }
        }
        titleCountLabel.text = "\(kMaxNoteTitleCount - titleTextField.unwrappedText.count)"
    }
}
