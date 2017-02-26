//
//  CategoryTableViewCell.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/25/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    //MARK: - @IBOutlets
    @IBOutlet var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
