//
//  DebtTableViewCell.swift
//  LePigeonRebelle
//
//  Created by walidebisi on 14/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit

class DebtTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "DebtCell"


    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var userOwed: UILabel!
    @IBOutlet weak var userPaying: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
