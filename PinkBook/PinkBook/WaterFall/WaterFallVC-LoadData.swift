//
//  WaterFallVC-LoadData.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/14.
//

import CoreData

extension WaterFallVC {
    func getDraftNotes() {
        //let draftNotes = try! context.fetch()
        let request = DraftNote.fetchRequest() as NSFetchRequest<DraftNote>
        
        let sortDescriptor1 = NSSortDescriptor(key: "updatedAt", ascending: false)
        request.sortDescriptors = [sortDescriptor1]
        
        showLoadHUD()
        backgroundContext.perform {
            if let draftNotes = try? backgroundContext.fetch(request) {
                self.draftNotes = draftNotes
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            self.hideLoadHUD()
        }
        
    }
}
