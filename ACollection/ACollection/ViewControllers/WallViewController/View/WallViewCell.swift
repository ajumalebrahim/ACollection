//
//  WallViewCell.swift
//  ACollection
//
//  Created by Ajumal Ebrahim on 11/22/18.
//  Copyright © 2018 Ajumal Ebrahim. All rights reserved.
//

import UIKit

class WallViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
        
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

}
