//
//  GroupTableViewCell.swift
//  LePigeonRebelle
//
//  Created by iMac on 07/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "GroupCell"
    
    // MARK: -
    
    @IBOutlet var groupName: UILabel!
    @IBOutlet var budget: UILabel!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
    

