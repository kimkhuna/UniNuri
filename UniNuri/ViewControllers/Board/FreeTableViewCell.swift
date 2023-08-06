//
//  FreeTableViewCell.swift
//  UniNuri
//
//  Created by 김경훈 on 2023/06/15.
//

import UIKit

class FreeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
