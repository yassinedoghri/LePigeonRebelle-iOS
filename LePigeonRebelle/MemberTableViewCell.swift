//
//  MemberTableViewCell.swift
//  LePigeonRebelle
//
//  Created by walidebisi on 12/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "MemberCell"
    
    @IBOutlet var memberName: UILabel!
    @IBOutlet var budget: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
