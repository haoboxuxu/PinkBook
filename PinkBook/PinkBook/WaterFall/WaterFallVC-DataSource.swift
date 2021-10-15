//
//  WaterFallVC-DataSource.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/15.
//

import Foundation

extension WaterFallVC {
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    //override func numberOfSections(in collectionView: UICollectionView) -> Int {
    //    // #warning Incomplete implementation, return the number of sections
    //    return 1
    //}
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isDraftNote {
            return draftNotes.count
        } else {
            return 13
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isDraftNote {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDraftNoteWaterFallCellID, for: indexPath) as! DraftNoteWaterFallCell
            cell.draftNote = draftNotes[indexPath.item]
            cell.deleteBtn.tag = indexPath.item
            cell.deleteBtn.addTarget(self, action: #selector(showAlter), for: .touchUpInside)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kWaterFallCellID, for: indexPath) as! WaterFallCell
            cell.imageView.image = UIImage(named: "ti\(indexPath.item+1)")
            return cell
        }
    }
}

extension WaterFallVC {
    private func deleteDraftNote(_ index: Int) {
        let draftNote = draftNotes[index]
        context.delete(draftNote)
        appDelegate.saveContext()
        draftNotes.remove(at: index)
        
        collectionView.performBatchUpdates {
            self.collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        }
    }
}

extension WaterFallVC {
    @objc private func showAlter(_ sender: UIButton) {
        
        let index = sender.tag
        
        let alertVC = UIAlertController(title: "提示", message: "确实删除笔记草稿吗", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "取消", style: .cancel)
        let action2 = UIAlertAction(title: "确认", style: .destructive) { _ in
            self.deleteDraftNote(index)
        }
        alertVC.addAction(action1)
        alertVC.addAction(action2)
        present(alertVC, animated: true)
    }
}
