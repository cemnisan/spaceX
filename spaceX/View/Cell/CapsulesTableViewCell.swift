//
//  TableViewCell.swift
//  spaceX
//
//  Created by Cem Nisan on 14.12.2021.
//

import UIKit

class CapsulesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var capsulesMissionLabel: UILabel!
    @IBOutlet weak var capsulesDetailLabel: UILabel!
    @IBOutlet weak var capsulesStatus: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
