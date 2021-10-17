//
//  NoteEditVC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/5.
//

import UIKit
import CoreLocation


class NoteEditVC: UIViewController {
    
    var draftNote: DraftNote?
    var updateDraftNoteFinished: (() -> ())?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var channelIcon: UIImageView!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var channelPlaceholderLabel: UILabel!
    @IBOutlet weak var poiNameIcon: UIImageView!
    @IBOutlet weak var poiNameLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    
    var photos = [
        UIImage(named: "ti1")!, UIImage(named: "ti3")!, UIImage(named: "ti2")!,
    ]
    
    //var videoUrl: URL? = Bundle.main.url(forResource: "rickroll", withExtension: "mp4")!
    var videoUrl: URL?
    
    var channel = ""
    var subChannel = ""
    var poiName = ""
    
    var photoCount: Int { photos.count }
    var isVideo: Bool { videoUrl != nil }
    var textViewIAView: TextViewIAView { textView.inputAccessoryView as! TextViewIAView }

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setUI()
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
        handleTFEditChanged()
    }
    
    
    @IBAction func saveNote(_ sender: Any) {
        
        validateNote()
        
        if let draftNote = draftNote {
            updateDraftNote(draftNote)
        } else {
            createDraftNote()
        }
    }
    
    @IBAction func postNote(_ sender: Any) {
        validateNote()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let channelVC = segue.destination as? ChannelVC {
            view.endEditing(true)
            channelVC.pvDelegate = self
        } else if let poiVC = segue.destination as? POIVC {
            poiVC.delegate = self
            poiVC.poiName = poiName
        }
    }
    
}

// MARK: - 笔记选择话题#后反向传值
extension NoteEditVC: ChannelVCDelegate {
    func updateChannel(channel: String, subChannel: String) {
        self.channel = channel
        self.subChannel = subChannel
        updateChannelUI()
    }
}

extension NoteEditVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard textView.markedTextRange == nil else { return }
        textViewIAView.currentTextCount = textView.text.count
    }
}

extension NoteEditVC: POIVCDelegate {
    func updatePOIBName(_ poiName: String) {
        if poiName == kPOIsInitArr[0][0] {
            self.poiName = ""
        } else {
            self.poiName = poiName
        }
        updatePOINameUI()
    }
}

extension NoteEditVC: UITextFieldDelegate {
    //func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //    textField.resignFirstResponder()
    //    return true
    //} //收起键盘
    
    //func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //    let isExceed = range.location >= kMaxNoteTitleCount || (textField.unwrappedText.count + string.count) > kMaxNoteTitleCount
    //    if isExceed {
    //        showTextHUD("标题最多输入\(kMaxNoteTitleCount)个字")
    //    }
    //    return !isExceed
    //}
}
