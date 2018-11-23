//
//  WallViewCell.swift
//  ACollection
//
//  Created by Ajumal Ebrahim on 11/22/18.
//  Copyright © 2018 Ajumal Ebrahim. All rights reserved.
//

import UIKit
import AEUrlLoader

class WallViewCell: UICollectionViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgVwIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
        
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func updateCellData(_ data: WallElement) {
        lblName.text = data.user.name
        imgVwIcon.loadImageAsync(with: data.user.profileImage.large)
    }

}
