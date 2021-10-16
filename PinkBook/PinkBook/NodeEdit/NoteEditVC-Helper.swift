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
}
