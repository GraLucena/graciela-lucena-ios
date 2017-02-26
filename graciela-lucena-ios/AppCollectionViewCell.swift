//
//  AppCollectionViewCell.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/25/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit

class AppCollectionViewCell: UICollectionViewCell {

    //MARK: - Properties
    @IBOutlet var appImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        appImage.layer.cornerRadius = 10
        appImage.clipsToBounds = true
        appImage.layer.borderWidth = 1.0
        appImage.layer.borderColor = UIColor.lightGrayColor().CGColor
        // Initialization code
    }

}
