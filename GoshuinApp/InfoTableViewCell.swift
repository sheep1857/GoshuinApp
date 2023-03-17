//
//  InfoTableViewCell.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/17.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet var nameTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(name: String) {
        nameTextLabel.text = name
    }
    
}
