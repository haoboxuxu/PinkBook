//
//  NoteEditVC-DraftNote.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/17.
//

extension NoteEditVC {
    func createDraftNote() {
        backgroundContext.perform {
            let draftNote = DraftNote(context: backgroundContext)
            
            if self.isVideo {
                draftNote.video = try? Data(contentsOf: self.videoUrl!)
            }
            
            draftNote.coverPhoto = self.photos[0].jpeg(.high)
            
            self.handlePhotos(draftNote)
            
            draftNote.isVideo = self.isVideo
            self.handleOthers(draftNote)
            
            DispatchQueue.main.async {
                self.showTextHUD("保存草稿成功")
            }
        }
    }
    
    func updateDraftNote(_ draftNote: DraftNote) {
        backgroundContext.perform {
            if !self.isVideo {
                self.handlePhotos(draftNote)
            }
            self.handleOthers(draftNote)
            
            DispatchQueue.main.async {
                self.updateDraftNoteFinished?()
            }
        }
        navigationController?.popViewController(animated: true)
    }
}

//写数据
extension NoteEditVC {
    private func handlePhotos(_ draftNote: DraftNote) {
        draftNote.coverPhoto = photos[0].jpeg(.high)
        
        var photos: [Data] = []
        for photo in self.photos{
            if let pngData = photo.pngData(){
                photos.append(pngData)
            }
        }
        
        draftNote.photos = try? JSONEncoder().encode(photos)
    }
    
    private func handleOthers(_ draftNote: DraftNote) {
        
        DispatchQueue.main.async {
            draftNote.title = self.titleTextField.exactText
            draftNote.text = self.textView.exactText
        }
        draftNote.channel = channel
        draftNote.subChannel = subChannel
        draftNote.poiName = poiName
        draftNote.updatedAt = Date()
        
        appDelegate.saveBackgroundContext()
    }
}
