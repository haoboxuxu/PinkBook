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
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var channelIcon: UIImageView!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var channelPlaceholderLabel: UILabel!
    
    
    var photos = [
        UIImage(named: "ti1")!, UIImage(named: "ti3")!, UIImage(named: "ti2")!,
    ]
    
    //var videoUrl: URL = Bundle.main.url(forResource: "rickroll", withExtension: "mp4")!
    var videoUrl: URL?
    
    var channel = ""
    var subChannel = ""
    
    
    var photoCount: Int { photos.count }
    var idVideo: Bool { videoUrl != nil }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let channelVC = segue.destination as? ChannelVC {
            channelVC.pvDelegate = self
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
