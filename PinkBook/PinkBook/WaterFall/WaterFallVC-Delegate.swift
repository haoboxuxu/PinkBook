//
//  WaterFallVC-Delegate.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/15.
//

import Foundation
import UIKit

extension WaterFallVC {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isDraftNote {
            let draftNote = draftNotes[indexPath.item]
            if let photosData = draftNote.photos, let photosDataArr = try? JSONDecoder().decode([Data].self, from: photosData) {
                
                let photos = photosDataArr.map { UIImage($0) ?? imagePH }
                
                let videoUrl = FileManager.default.save(draftNote.video, to: "video", as: "\(UUID().uuidString).mp4")
                
                let noteEditVC = storyboard?.instantiateViewController(identifier: kNoteEditVCID) as! NoteEditVC
                noteEditVC.draftNote = draftNote
                noteEditVC.photos = photos
                noteEditVC.videoUrl = videoUrl
                noteEditVC.updateDraftNoteFinished = {
                    self.getDraftNotes()
                }
                
                navigationController?.pushViewController(noteEditVC, animated: true)
                
            } else {
                showTextHUD("加载笔记草稿失败")
            }
            
        } else {
            
        }
    }
}
