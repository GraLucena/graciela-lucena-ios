//
//  AppTableViewCell.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/25/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit

class AppTableViewCell: UITableViewCell {

    
    //MARK: - @IBOutlets
    @IBOutlet var appImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var category: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        appImage.layer.cornerRadius = 10
        appImage.clipsToBounds = true
        appImage.layer.borderWidth = 1.0
        appImage.layer.borderColor = UIColor.lightGrayColor().CGColor
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
