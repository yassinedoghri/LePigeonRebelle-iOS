//
//  AddMemberView.swift
//  LePigeonRebelle
//
//  Created by walidebisi on 18/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit

@IBDesignable class AddMemberView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    

}
