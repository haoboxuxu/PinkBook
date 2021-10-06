//
//  TabBarC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/2.
//

import UIKit
import YPImagePicker

class TabBarC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is PostVC {
            
            // TODO: 判断登陆
            
            var config = YPImagePickerConfiguration()
            // MARK: 通用配置
            config.isScrollToChangeModesEnabled = false //关闭滑动改模式避免修图手势冲突
            config.onlySquareImagesFromCamera = false
            config.albumName = Bundle.main.appName
            config.startOnScreen = YPPickerScreen.library
            config.screens = [.library, .video, .photo]
            config.preferredStatusBarStyle = UIStatusBarStyle.default
            config.maxCameraZoomFactor = kMaxCameraZoomFactor
            
            // MARK: 相册配置
            config.library.defaultMultipleSelection = true
            config.library.maxNumberOfItems = kMaxPhotoCount
            config.library.spacingBetweenItems = kSpacingBetweenItems
            config.gallery.hidesRemoveButton = false
            
            // MARK: 视频配置
            
            
            let picker = YPImagePicker(configuration: config)
            
            picker.didFinishPicking { [unowned picker] items, cancelled in
                if cancelled {
                    print("Picker was canceled")
                }
                
                for item in items {
                    switch item {
                    case let .photo(photo):
                        print(photo)
                    case let .video(video):
                        print(video)
                    }
                }
                
                //picker.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
                picker.dismiss(animated: true)
            }
            present(picker, animated: true)

            
            return false
        }
        return true
    }

}
