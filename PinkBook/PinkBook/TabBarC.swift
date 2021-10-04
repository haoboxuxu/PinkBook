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
            config.maxCameraZoomFactor = 5.0
            
            // MARK: 相册配置
            config.library.defaultMultipleSelection = true
            config.library.maxNumberOfItems = kMaxPhotoCount
            config.library.spacingBetweenItems = 2.0
            config.gallery.hidesRemoveButton = false
            
            // MARK: 视频配置
            
            
            let picker = YPImagePicker(configuration: config)
            
            picker.didFinishPicking { [unowned picker] items, cancelled in
                if cancelled {
                        print("Picker was canceled")
                    }
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)

            
            return false
        }
        return true
    }

}
