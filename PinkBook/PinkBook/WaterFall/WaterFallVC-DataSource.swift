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
    private func deleteDraftNote(_ index: Int){
        backgroundContext.perform {
            let draftNote = self.draftNotes[index]
            //数据1:本地CoreData里的
            backgroundContext.delete(draftNote)
            appDelegate.saveBackgroundContext()
            //数据2:内存中的
            self.draftNotes.remove(at: index)
            
            //UI
            DispatchQueue.main.async {
                //用deleteItems会出现'index out of range'的错误,因为DataSource里面的index没有更新过来,故直接使用reloadData
                self.collectionView.reloadData()
                self.showTextHUD("删除草稿成功")
            }
        }
    }
}

extension WaterFallVC {
    @objc private func showAlter(_ sender: UIButton) {
        let index = sender.tag
        
        let alert = UIAlertController(title: "提示", message: "确认删除该草稿吗?", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "取消", style: .cancel)
        let action2 = UIAlertAction(title: "确认", style: .destructive) {
            _ in self.deleteDraftNote(index)
        }
        alert.addAction(action1)
        alert.addAction(action2)
        
        present(alert, animated: true)
    }
}
