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
    }
    
    func configureUI(with capsule: Capsules) {
        capsulesDetailLabel.text = capsule.details != nil ? capsule.details : "unkown"
        capsulesStatus.setTitle(capsule.status, for: .normal)
        
        if let status = CapsulesStatus.getStatus(status: capsule.status ?? "unkown") {
            switch status {
            case .active:
                capsulesStatus.backgroundColor = #colorLiteral(red: 0.1527362466, green: 0.5281193256, blue: 0.328921169, alpha: 1)
            case .unkown:
                capsulesStatus.backgroundColor = #colorLiteral(red: 0.8625278473, green: 0.2073233128, blue: 0.2703085542, alpha: 1)
            case .retired:
                capsulesStatus.backgroundColor = #colorLiteral(red: 0.04930239171, green: 0.4321121573, blue: 0.9915542006, alpha: 1)
            case .destroyed:
                capsulesStatus.backgroundColor = #colorLiteral(red: 0.8625278473, green: 0.2073233128, blue: 0.2703085542, alpha: 1)
            }
        }
        
        if let mission = capsule.missions {
            capsulesMissionLabel.text = mission.isEmpty == false ? mission[0].name ?? "" : "unkown"
        }
    }
    
}
