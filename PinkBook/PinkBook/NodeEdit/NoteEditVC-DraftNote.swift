//
//  NoteEditVC-DraftNote.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/17.
//

extension NoteEditVC {
    func createDraftNote() {
        let draftNote = DraftNote(context: context)
        
        if isVideo {
            draftNote.video = try? Data(contentsOf: videoUrl!)
        }
        
        draftNote.coverPhoto = photos[0].jpeg(.high)
        
        handlePhotos(draftNote)
        
        draftNote.isVideo = isVideo
        handleOthers(draftNote)
    }
    
    func updateDraftNote(_ draftNote: DraftNote) {
        if !isVideo {
            handlePhotos(draftNote)
        }
        handleOthers(draftNote)
        updateDraftNoteFinished?()
        navigationController?.popViewController(animated: true)
    }
}

//写数据
extension NoteEditVC {
    private func handlePhotos(_ draftNote: DraftNote) {
        draftNote.coverPhoto = photos[0].jpeg(.high)
        
        var photos: [Data] = []
        for photo in self.photos {
            if let pngData = photo.pngData() {
                photos.append(pngData)
            }
        }
        
        draftNote.photos = try? JSONEncoder().encode(photos)
    }
    
    private func handleOthers(_ draftNote: DraftNote) {
        draftNote.title = titleTextField.exactText
        draftNote.text = textView.exactText
        draftNote.channel = channel
        draftNote.subChannel = subChannel
        draftNote.poiName = poiName
        draftNote.updatedAt = Date()
        
        appDelegate.saveContext()
    }
}
