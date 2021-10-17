//
//  NoteEditVC-UI.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/16.
//

import Foundation

extension NoteEditVC {
    func setUI() {
        setDraftNoteEditUI()
    }
}

extension NoteEditVC {
    private func setDraftNoteEditUI() {
        if let draftNote = draftNote {
            titleTextField.text = draftNote.title
            textView.text = draftNote.text
            channel = draftNote.channel!
            subChannel = draftNote.subChannel!
            poiName = draftNote.poiName!
            
            if !subChannel.isEmpty {
                updateChannelUI()
            }
            
            if !poiName.isEmpty {
                updatePOINameUI()
            }
        }
    }
    
    func updateChannelUI() {
        channelLabel.text = subChannel
        channelIcon.tintColor = bluedColor
        channelLabel.textColor = bluedColor
        channelPlaceholderLabel.isHidden = true
    }
    
    func updatePOINameUI() {
        if poiName == "" {
            poiNameLabel.text = "添加地点"
            poiNameLabel.textColor = .label
            poiNameIcon.tintColor = .label
        } else {
            poiNameLabel.text = self.poiName
            poiNameLabel.textColor = bluedColor
            poiNameIcon.tintColor = bluedColor
        }
    }
}
