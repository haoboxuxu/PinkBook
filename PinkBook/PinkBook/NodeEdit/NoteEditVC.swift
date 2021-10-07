//
//  NoteEditVC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/5.
//

import UIKit


class NoteEditVC: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var photos = [
        UIImage(named: "ti1")!, UIImage(named: "ti3")!, UIImage(named: "ti2")!,
    ]
    
    //var videoUrl: URL = Bundle.main.url(forResource: "rickroll", withExtension: "mp4")!
    var videoUrl: URL?
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var photoCount: Int { photos.count }
    var idVideo: Bool { videoUrl != nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }

    @IBAction func tfEditBegin(_ sender: Any) {
        titleCountLabel.isHidden = false
    }
    
    
    @IBAction func tfEditEnd(_ sender: Any) {
        titleCountLabel.isHidden = true
    }
    
    @IBAction func tfEditExit(_ sender: Any) {
        //hide keyboard
    }
    @IBAction func tfDditChanged(_ sender: Any) {
        titleCountLabel.text = "\(kMaxNoteTitleCount - titleTextField.unwrappedText.count)"
    }
    
}

extension NoteEditVC: UITextFieldDelegate {
    //func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //    textField.resignFirstResponder()
    //    return true
    //} //收起键盘
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let isExceed = range.location >= kMaxNoteTitleCount || (textField.unwrappedText.count + string.count) > kMaxNoteTitleCount
        if isExceed {
            showTextHUD("标题最多输入\(kMaxNoteTitleCount)个字")
        }
        return !isExceed
    }
}
