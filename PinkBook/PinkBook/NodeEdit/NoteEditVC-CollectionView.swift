//
//  NoteEditVC-CollectionView.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/6.
//

import YPImagePicker
import AVKit
import SKPhotoBrowser
import MBProgressHUD

extension NoteEditVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCellID, for: indexPath) as! PhotoCell
        cell.imageView.image = photos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let photoFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kPhotoFooterID, for: indexPath) as! PhotoFooter
            photoFooter.addPhotoButton.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
            return photoFooter
        default:
            fatalError("photoFooter of collectionView error!")
        }
    }
    
}

extension NoteEditVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if idVideo {
            let playerVC = AVPlayerViewController()
            playerVC.player = AVPlayer(url: videoUrl!)
            present(playerVC, animated: true) {
                playerVC.player?.play()
            }
        } else {
            // 1. create SKPhoto Array from UIImage
            var images: [SKPhoto] = []
            for photo in photos {
                images.append(SKPhoto.photoWithImage(photo))
            }

            // 2. create PhotoBrowser Instance, and present from your viewController.
            let browser = SKPhotoBrowser(photos: images, initialPageIndex: indexPath.item)
            browser.delegate = self
            SKPhotoBrowserOptions.displayAction = false
            SKPhotoBrowserOptions.displayDeleteButton = true
            present(browser, animated: true, completion: {})
        }

    }
}

extension NoteEditVC: SKPhotoBrowserDelegate {
    func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
        photos.remove(at: index)
        reload()
        photoCollectionView.reloadData()
    }
}


extension NoteEditVC {
    @objc private func addPhoto(sender: UIButton) {
        if photoCount < kMaxPhotoCount {
            var config = YPImagePickerConfiguration()
            // MARK: 通用配置
            config.albumName = Bundle.main.appName
            config.screens = [.library]
            
            // MARK: 相册配置
            config.library.defaultMultipleSelection = true
            config.library.maxNumberOfItems = kMaxPhotoCount - photoCount
            config.library.spacingBetweenItems = kSpacingBetweenItems
            config.gallery.hidesRemoveButton = false
            
            // MARK: 视频配置
            
            
            let picker = YPImagePicker(configuration: config)
            
            picker.didFinishPicking { [unowned picker] items, _ in
                for item in items {
                    if case let .photo(photo) = item {
                        self.photos.append(photo.image)
                    }
                }
                
                self.photoCollectionView.reloadData()
                
                picker.dismiss(animated: true)
            }
            present(picker, animated: true)
        } else {
            showTextHUD("最多只能选测\(kMaxPhotoCount)照片")
        }
    }
}

