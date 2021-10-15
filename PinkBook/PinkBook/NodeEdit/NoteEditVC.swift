//
//  NoteEditVC.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/5.
//

import UIKit
import CoreLocation


class NoteEditVC: UIViewController {
    
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
        guard titleTextField.markedTextRange == nil else { return }
        if titleTextField.unwrappedText.count > kMaxNoteTitleCount {
            titleTextField.text = String(titleTextField.unwrappedText.prefix(kMaxNoteTitleCount))
            
            DispatchQueue.main.async {
                let end = self.titleTextField.endOfDocument
                self.titleTextField.selectedTextRange = self.titleTextField.textRange(from: end, to: end)
            }
        }
        titleCountLabel.text = "\(kMaxNoteTitleCount - titleTextField.unwrappedText.count)"
    }
    
    
    @IBAction func saveNote(_ sender: Any) {
        
        guard textViewIAView.currentTextCount <= kMaxNoteTextCount else {
            showTextHUD("正文最多输入\(kMaxNoteTextCount)个字")
            return
        }
        
        let draftNote = DraftNote(context: context)
        
        if isVideo {
            draftNote.video = try? Data(contentsOf: videoUrl!)
        }
        
        draftNote.coverPhoto = photos[0].jpeg(.high)
        
        var photos: [Data] = []
        for photo in self.photos {
            if let pngData = photo.pngData() {
                photos.append(pngData)
            }
        }
        
        draftNote.photos = try? JSONEncoder().encode(photos)
        
        draftNote.isVideo = isVideo
        draftNote.title = titleTextField.exactText
        draftNote.text = textView.exactText
        draftNote.channel = channel
        draftNote.subChannel = subChannel
        draftNote.poiName = poiName
        draftNote.updatedAt = Date()
        
        
        appDelegate.saveContext()
    }
    
    @IBAction func postNote(_ sender: Any) {
        
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
        
        channelLabel.text = subChannel
        channelIcon.tintColor = bluedColor
        channelLabel.textColor = bluedColor
        channelPlaceholderLabel.isHidden = true
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
            poiNameLabel.text = "添加地点"
            poiNameLabel.textColor = .label
            poiNameIcon.tintColor = .label
        } else {
            self.poiName = poiName
            poiNameLabel.text = self.poiName
            poiNameLabel.textColor = bluedColor
            poiNameIcon.tintColor = bluedColor
        }
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
