//
//  MemberTableViewCell.swift
//  LePigeonRebelle
//
//  Created by walidebisi on 12/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit
import AvatarImageView

struct TableAvatarImageConfig: AvatarImageViewConfiguration {
    let shape: Shape = .circle
    var fontName: String? = "Roboto"
}

class MemberTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "MemberCell"
    
    @IBOutlet var memberName: UILabel!
    @IBOutlet weak var budget: UITextField!
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet var avatarImageView: AvatarImageView! {
        didSet {
            avatarImageView.configuration = TableAvatarImageConfig()
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
