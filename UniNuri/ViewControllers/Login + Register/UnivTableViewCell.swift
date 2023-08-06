//
//  UnivTableViewCell.swift
//  UniNuri
//
//  Created by 김경훈 on 2023/07/07.
//

import UIKit

class UnivTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
