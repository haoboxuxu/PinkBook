//
//  POICell.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/9.
//

import UIKit

class POICell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var poi = ["", ""] {
        didSet {
            titleLabel.text = poi.first
            addressLabel.text = poi.last
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
